---
layout: page
title: "dclDebug.SuperResultError"
date: 2012-07-29 14:33
comments: false
sharing: true
footer: true
---

`dclDebug.SuperResultError` is present only when `dcl/debug` is required. It is thrown when
a method used for a supercall, or an around advice does not follow the double function
pattern and returns something other than a function. It works for supercalls, and
class-level and object-level advices.

## Examples

{% codeblock Wrong result lang:js %}
var dcl = require("dcl"),
	dclDebug = require("dcl/debug");

var A = dcl(null, {
  declaredClass: "A",
  m: dcl.superCall(function(sup){
    return "Instead of a function I return a string.";
  })
});

// At this point dclError.SuperResultError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock %}
dcl: around advice or supercall should return a function in: A, method: m
{% endcodeblock %}
