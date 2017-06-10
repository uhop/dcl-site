---
layout: page
title: "dcl.CycleError"
date: 2017-06-09 00:12
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.CycleError` is present only when `dcl/debug` is imported. Otherwise, `Error` will be thrown.

It is thrown, when `dcl` encounters an impossible inheritance. For example, when `A` depends on `B`, and `B` depends on `A`.

`dcl.CycleError` is based on [dcl.DclError](/2.x/docs/debug_js/dclerror/).

## Examples

{% codeblock Impossible cycle lang:js %}
var dcl = require("dcl/debug");

var A = dcl({declaredClass: "A"});
var B = dcl({declaredClass: "B"});
var AB = dcl([A, B], {declaredClass: "AB"});
var BA = dcl([B, A], {declaredClass: "BA"});

var Impossible = dcl([AB, BA], {
  declaredClass: "Impossible"
});

// At this point dcl.CycleError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock lang:text %}
dcl: base class cycle in Impossible, bases (AB, BA) are mutually dependent
{% endcodeblock %}
