---
layout: page
title: "dcl.isInstanceOf()"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

While `instanceof` operator works only for linear prototypal inheritance, `dcl.isInstanceOf()` is
its counterpart for mixins.

## Description

JavaScript provides `instanceof` operator to check if an object was produced with a certain constructor or its delegate.
Unfortunately this functionality works only for a linear delegation. Mixins are by necessity mixed in, so they cannot be
detected by `instanceof`. This functionality is provided by `dcl.isInstanceOf()` function, which takes the object and
the constructor as parameters, and returns `true`, when the object contains the supplied mixin or base constructor, and `false` otherwise.

{% codeblock dcl.isInstanceOf() lang:js %}
var A = dcl(null, {});
var B = dcl(null, {});
var C = dcl(null, {});
var D = dcl(null, {});

var ABC = dcl([A, B, C], {});
var abc = new ABC();

console.log(abc instanceof A); // true
console.log(abc instanceof B); // false
console.log(abc instanceof C); // false
console.log(abc instanceof D); // false

console.log(dcl.isInstanceof(abc, A)); // true
console.log(dcl.isInstanceof(abc, B)); // true
console.log(dcl.isInstanceof(abc, C)); // true
console.log(dcl.isInstanceof(abc, D)); // false
{% endcodeblock %}

## Notes

This function has a linear complexity on a number of mixins.
