---
layout: page
title: "dclDebug.CycleError"
date: 2012-07-29 00:12
comments: false
sharing: true
footer: true
---

*Version 1.x*

`dclDebug.CycleError` is present only when `dcl/debug` is required. It is thrown when
`dcl` encounters an impossible inheritance. For example, when `A` depends on `B`, and `B` depends on `A`.

## Examples

{% codeblock Impossible cycle lang:js %}
var dcl = require("dcl"),
	dclDebug = require("dcl/debug");

var A = dcl(null, {
  declaredClass: "A"
});

var B = dcl(null, {
  declaredClass: "B"
});

var AB = dcl([A, B], {
  declaredClass: "AB"
});

var BA = dcl([B, A], {
  declaredClass: "BA"
});

var Impossible = dcl([AB, BA], {
  declaredClass: "Impossible"
});

// At this point dclError.CycleError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock %}
dcl: base class cycle found in: Impossible -
bases: B, A are mutually dependent
{% endcodeblock %}
