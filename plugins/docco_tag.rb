# Title: Docco (Literate Programming) Tag for Jekyll
# Author: Eugene Lazutkin http://lazutkin.com
# Description: Split programming code into comments and code and imports it to a post or a page. The idea is taken from
# the awesome docco (a literate programming documentation generator) https://github.com/jashkenas/docco (MIT license)
# Configuration: You can set default import path in _config.yml (defaults to code_dir: downloads/code)
# Note: If you import a file with yaml front matter, the yaml will be stripped out.
#
# Syntax {% docco path/to/file %}
#
# Example 1:
# {% docco file.js %}
#
# This will import source/downloads/code/file.js (or whatever code_dir point to), split it into text and code snippets,
# and render it inline.

require 'pathname'
require './plugins/octopress_filters'

module Jekyll


  class DoccoTag < Liquid::Tag
    include OctopressFilters

    LANGUAGES = {
        :coffee  => {:name => "coffeescript",  :single => "#"},
        :rb      => {:name => "ruby",          :single => "#"},
        :py      => {:name => "python",        :single => "#"},
        :feature => {:name => "gherkin",       :single => "#"},
        :yaml    => {:name => "yaml",          :single => "#"},
        :tex     => {:name => "tex",           :single => "%"},
        :latex   => {:name => "tex",           :single => "%"},
        :js      => {:name => "javascript",    :single => "//"},
        :java    => {:name => "java",          :single => "//"},
        :scala   => {:name => "scala",         :single => "//"},
        :c       => {:name => "c",             :single => "//"},
        :h       => {:name => "c",             :single => "//"},
        :cpp     => {:name => "cpp",           :single => "//"},
        :php     => {:name => "php",           :single => "//"},
        :hs      => {:name => "haskell",       :single => "--"},
        :erl     => {:name => "erlang",        :single => "%"},
        :hrl     => {:name => "erlang",        :single => "%"},
        :lua     => {:name => "lua",           :single => "--"},
        :scm     => {:name => "scheme",        :single => ";;"},
    }

    def initialize(tag_name, markup, tokens)
      @file, @type = nil, nil
      if markup =~ /^(\S+)/
        @file = $1.strip
        if @file =~ /\.(\w+)$/
          @type = $1
        end
      end
      super
    end

    def render(context)
      code_dir = (context.registers[:site].config['code_dir'].sub(/^\//,'') || 'downloads/code')
      code_path = (Pathname.new(context.registers[:site].source) + code_dir).expand_path
      file = code_path + @file

      if File.symlink?(code_path)
        return "Code directory '#{code_path}' cannot be a symlink"
      end

      unless file.file?
        return "File #{file} could not be found"
      end

      Dir.chdir(code_path) do
        contents = file.read
        # skip possible front matter
        if contents =~ /\A-{3}.+[^\A]-{3}\n(.+)/m
          contents = $1.lstrip
        end
        sections, docs, code = [], [], []
        if @type.nil?
          # unknown language => everything is a code
          sections << [docs, [contents]]
        else
          # parse a file
          starts_with_comment = Regexp.new "^\\s*#{Regexp.escape(LANGUAGES[@type.to_sym][:single])}\\s?"
          lines = contents.split "\n"
          lines.each do |line|
            if line.match starts_with_comment
              if code.any?
                sections << [docs, code]
                docs, code = [], []
              end
              docs << line.sub(starts_with_comment, "")
            else
              code << line
            end
          end
          sections << [docs, code] if docs.any? || code.any?
        end
        # generate a markdown
        contents = []
        sections.each do |section|
          docs = section[0]
          contents.push *docs
          code = section[1]
          empty_code = true
          code.each do |line|
            if empty_code && !line.strip.empty?
              empty_code = false
              #contents << "```#{LANGUAGES[@type.to_sym][:name]}"
              contents << "{% codeblock file.js %}"
            end
            contents << line
          end
          if !empty_code
            #contents << "```"
            contents << "{% endcodeblock %}"
            contents << "<div class='docco-section-end'></div>"
          end
        end
        contents = contents.join "\n"
        # render the result
        contents = pre_filter contents
        partial = Liquid::Template.parse contents
        context.stack do
          partial.render context
        end
      end
    end
  end
end

Liquid::Template.register_tag('docco', Jekyll::DoccoTag)
