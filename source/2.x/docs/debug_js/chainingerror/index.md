---
layout: page
title: "dclDebug.ChainingError"
date: 2012-07-29 00:12
comments: false
sharing: true
footer: true
---

`dclDebug.ChainingError` is present only when `dcl/debug` is required. It is thrown when
`dcl` is used to mix bases with different chaining orders for the same method.

## Examples

{% codeblock Conflicting chains lang:js %}
var dcl = require("dcl"),
	dclDebug = require("dcl/debug");

var A = dcl(null, {
  declaredClass: "A"
});
dcl.chainAfter(A, "m");

var B = dcl(null, {
  declaredClass: "B"
});
dcl.chainBefore(B, "m");

var ChainConflict = dcl([A, B], {
  declaredClass: "ChainConflict"
});

// At this point dclError.ChainingError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock %}
dcl: conflicting chain directives from bases found in: ChainConflict, method: m -
it was ERRONEOUSLY CHAINED BEFORE AND AFTER yet A sets it to CHAINED AFTER
{% endcodeblock %}
