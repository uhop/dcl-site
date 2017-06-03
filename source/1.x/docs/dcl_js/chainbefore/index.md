---
layout: page
title: "dcl.chainBefore()"
date: 2012-07-29 00:07
comments: false
sharing: true
footer: true
---

*Version 1.x*

This function declares that methods with a certain name should be chained in the reversed inheritance order
(top-most method runs first).

## Description

Use `dcl.chainBefore()` to set a chaining rule for a method.

{% codeblock dcl.chainBefore() lang:js %}
var A = dcl(null, {
  ...
  method: function(...){...},
  ...
});
dcl.chainBefore(A, "method");
{% endcodeblock %}

Following rules should be followed:

* It is impossible to "unchain" a chained method.
* It is impossible to change a chained method once it was set from "before" to "after" or in the opposite direction.
* Chaining can be declared only for base-less "classes".
* It is an error to mix "classes" with different chaining rules for the same method.

## Notes

Chaining using "before" is frequently used for destructors or similar methods.

It is possible to declare chaining for a method without actually declaring the method.
