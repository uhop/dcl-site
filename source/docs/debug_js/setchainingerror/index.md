---
layout: page
title: "dclDebug.SetChainingError"
date: 2012-07-29 00:12
comments: false
sharing: true
footer: true
---

`dclDebug.SetChainingError` is present only when `dcl/debug` is required. It is thrown when
setting different chaining for the same method.

## Examples

{% codeblock Setting conflicting chaining lang:js %}
var dcl = require("dcl"),
	dclDebug = require("dcl/debug");

var A = dcl(null, {
  declaredClass: "A"
});
dcl.chainAfter(A, "m");
dcl.chainBefore(A, "m");

// At this point dclError.SetChainingError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock %}
dcl: attempt to set conflicting chain directives in: A, method: m -
it was CHAINED AFTER yet being changed to CHAINED BEFORE
{% endcodeblock %}
