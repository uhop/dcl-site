---
layout: page
title: "dcl.prop() and dcl.Prop"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

## `dcl.Prop`

`dcl.Prop` is a constructor function used to define a property descriptor decorator. In most cases, it is not constructed manually, but created by `dcl.prop()` described below.

The constructor creates a super-simple object with one property: `x`, which is an argument of the constructor. This constructor is needed solely for possible introspections with `instanceof`.

## `dcl.prop()`

`dcl.prop(arg)` is a function that takes the property descriptor, and returns an instance of `dcl.Prop`.

This is its full definition:

{% codeblock Implementation of dcl.prop() lang:js %}
dcl.prop = function (arg) {
  return dcl.Prop(arg);
};
{% endcodeblock %}

It is used by `dcl` to mark explicitly property descriptors.

## Examples

### Define a property using a descriptor

{% codeblock Define a property lang:js %}
var A = dcl({
    x: dcl.prop({
        get: function ()  { return this.y || 0; },
        set: function (x) { return this.y = 2 * x; }
      })
  });

var a = new A();
console.log(a.x); // 0
a.x = 3;
console.log(a.x); // 6
{% endcodeblock %}

### Define a "class" using descriptors

All properties can be described as an object that contains property descriptors.

{% codeblock Use property descriptors lang:js %}
var A = dcl(dcl.prop({
    life: {value: 42},
    answer: {
      value: function () { return this.life; },
      enumerable: false
    }
  }));
{% endcodeblock %}

## Notes

Property descriptors are defined in [Object.defineProperty()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty).
