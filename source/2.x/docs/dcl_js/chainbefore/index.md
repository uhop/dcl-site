---
layout: page
title: "dcl.chainBefore()"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

This function declares that methods with a certain name should be chained in the reversed inheritance order
(the last method runs first).

## Description

`dcl.chainBefore()` sets the `before` chaining rule for a method. It takes two parameters:

* `Ctr` - the constructor function created by [dcl()](/2.x/docs/dcl_js/dcl/).
* `name` - the method name to be chained in `Ctr`'s prototype.

Following rules should be followed:

* It is impossible to "unchain" a chained method.
* It is impossible to change a chained method once it was set from "before" to "after" or in the opposite direction.
* Chaining should be declared only for base-less "classes".
* It is an error to mix "classes" with different chaining rules for the same method.
* It is possible to declare chaining for a method without actually declaring the method.

The function returns `true`, if it was able to define a required chaining, `false`, if a constructor was not defined by [dcl()](/2.x/docs/dcl_js/dcl/), and throws an error, if a chaining conflict was detected.

{% codeblock dcl.chainBefore() lang:js %}
var A = dcl({
  ...
  method: function (...) {...},
  ...
});
dcl.chainBefore(A, "method");
{% endcodeblock %}

## Notes

Chaining using "before" is frequently used for destructors or similar methods.

### Implementation

It is implemented in terms of [dcl.chainWith()](/2.x/docs/dcl_js/chainwith/) and [dcl.weaveBefore](/2.x/docs/dcl_js/weavebefore/):

{% codeblock Implementation of dcl.chainBefore() lang:js %}
dcl.chainBefore = function (Ctr, name) {
  return dcl.chainWith(Ctr, name, dcl.weaveBefore);
};
{% endcodeblock %}
