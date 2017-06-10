---
layout: page
title: "dcl.SuperError"
date: 2017-06-09 14:32
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.SuperError` is present only when `dcl/debug` is imported. It is thrown, when various errors related to super calls are detected. It works for supercalls in class-level and object-level advices.

## Examples

### Wrong super

{% codeblock Wrong super lang:js %}
var dcl = require("dcl/debug");

var A = dcl({
  declaredClass: "A",
  m: 42 // not a function
});

var B = dcl(A, {
  declaredClass: "B",
  m: dcl.superCall(function (sup) {
    return sup ? sup.call(this) : 0;
  })
});

// At this point dcl.SuperError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock lang:text %}
dcl: super call error in B, while weaving B, method m (value) wrong arg
{% endcodeblock %}

### Wrong supercalling method

{% codeblock Wrong supercalling method lang:js %}
var dcl = require("dcl/debug");

var A = dcl({
  declaredClass: "A",
  m: dcl.superCall("Should be a function, but it is a string.")
});

// At this point dcl.SuperError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock lang:text %}
dcl: super call error in A, while weaving A, method m (value) wrong call
{% endcodeblock %}

### Wrong result

{% codeblock Wrong result lang:js %}
var dcl = require("dcl/debug");

var A = dcl({
  declaredClass: "A",
  m: dcl.superCall(function (sup) {
    return "Instead of a function I return a string.";
  })
});

// At this point dcl.SuperError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock lang:text %}
dcl: super call error in A, while weaving A, method m (value) wrong result
{% endcodeblock %}

### Wrong supercalling getter

{% codeblock Wrong supercalling method lang:js %}
var dcl = require("dcl/debug");

var A = dcl({
  declaredClass: "A",
  m: dcl.prop({
    get: dcl.superCall("Should be a function, but it is a string.")
  })
});

// At this point dcl.SuperError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock lang:text %}
dcl: super call error in A, while weaving A, method m (get) wrong call
{% endcodeblock %}

### Wrong object super

{% codeblock Wrong super lang:js %}
var dcl = require("dcl/debug"),
  advise = require("dcl/advise");

var a = {m: 42};

advise.around(a, "m", function (sup) {
  return function () { return 33; };
});

// At this point dcl.SuperError will be thrown.
{% endcodeblock %}

You will see the following exception:

{% codeblock lang:text %}
dcl: super call error in object of UNNAMED, while weaving method m (value) wrong arg
{% endcodeblock %}
