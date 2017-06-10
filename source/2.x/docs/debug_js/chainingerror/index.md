---
layout: page
title: "dcl.ChainingError"
date: 2017-06-09 00:12
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.ChainingError` is present only when `dcl/debug` is imported. Otherwise, `Error` will be thrown.

It is thrown, when `dcl` is used to mix bases with different chaining orders for the same method.

`dcl.ChainingError` is based on [dcl.DclError](/2.x/docs/debug_js/dclerror/).


## Examples

{% codeblock Conflicting chains lang:js %}
var dcl = require("dcl/debug");

var A = dcl({declaredClass: "A"});
dcl.chainAfter(A, "m");

var B = dcl({declaredClass: "B"});
dcl.chainBefore(B, "m");

var ChainConflict = dcl([A, B], {
  declaredClass: "ChainConflict"
});

// At this point dcl.ChainingError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock lang:text %}
dcl: conflicting chain directives in ChainConflict for m, was after, set to before
{% endcodeblock %}
