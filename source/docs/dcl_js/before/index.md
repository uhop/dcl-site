---
layout: page
title: "dcl.before()"
date: 2012-07-29 00:07
comments: false
sharing: true
footer: true
---

This is a convenience decorator to define a `before` advice.

## Description

This is a shortcut function to define one `before` advice. Logically it is defined as:

{% codeblock dcl.before() lang:js %}
dcl.before = function(advice){
  return dcl.advise({
    before: advice
  });
};
{% endcodeblock %}

It means that instead of:

{% codeblock Long lang:js %}
method: dcl.advise({
  before: advice
})
{% endcodeblock %}

It is possible to write a shorter version:

{% codeblock Short lang:js %}
method: dcl.before(advice)
{% endcodeblock %}
