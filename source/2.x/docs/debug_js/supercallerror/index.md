---
layout: page
title: "dclDebug.SuperCallError"
date: 2012-07-29 14:32
comments: false
sharing: true
footer: true
---

`dclDebug.SuperCallError` is present only when `dcl/debug` is required. It is thrown when
an argument is not a function. It works for supercalls, and class-level and object-level
advices.

## Examples

{% codeblock Wrong supercalling method lang:js %}
var dcl = require("dcl"),
	dclDebug = require("dcl/debug");

var A = dcl(null, {
  declaredClass: "A",
  m: dcl.superCall("Should be a function, but it is a string.")
});

// At this point dclError.SuperCallError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock %}
dcl: argument of around advice or supercall decorator
should be a function in: A, method: m
{% endcodeblock %}
