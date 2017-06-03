---
layout: post
title: "1.0 is public"
date: 2012-10-05 21:40
comments: false
categories: announce
---

Finally after months of private use 1.0 version of `dcl` is out
in the open.

What is `dcl`? It is a micro library for OOP/AOP. It works in
[node.js][] and modern browsers, supports [AMD][], and completely
[open source](http://github.com/uhop/dcl).

<!-- More -->

If you plan to use it in your [node.js][] project install it
like this:

{% codeblock %}
npm install dcl
{% endcodeblock %}

For your browser-based projects I suggest to use [volo.js][]:

{% codeblock %}
volo install -amd uhop/dcl
{% endcodeblock %}

It is licensed under BSD or AFLv2 (your choice), all contributions
are legally clean and covered by CLA, so you can use it not only
for pet projects, but at work too.

For more information hop on [what is dcl?](/about) and learn more.
Do not forget to look at extensive [documentation](/1.x/docs), or
[shoot me an email](mailto:eugene@dcljs.org), if you still have
more questions.

[node.js]:  http://nodejs.org   node.js
[volo.js]:  http://volojs.org   volo.js
[AMD]:      https://github.com/amdjs/amdjs-api/wiki/AMD   AMD