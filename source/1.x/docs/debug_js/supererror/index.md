---
layout: page
title: "dclDebug.SuperError"
date: 2012-07-29 14:32
comments: false
sharing: true
footer: true
---

*Version 1.x*

`dclDebug.SuperError` is present only when `dcl/debug` is required. It is thrown when
a super method is not a function. It works for supercalls, and class-level and object-level
advices.

## Examples

{% codeblock Wrong super lang:js %}
var dcl = require("dcl"),
	dclDebug = require("dcl/debug");

var A = dcl(null, {
  declaredClass: "A",
  m: 42 // not a function
});

var B = dcl(A, {
  declaredClass: "B",
  m: dcl.superCall(function(sup){
    return sup ? sup.call(this) : 0;
  })
});

// At this point dclError.SuperError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock %}
dcl: super method should be a function in: B, method: m
{% endcodeblock %}
