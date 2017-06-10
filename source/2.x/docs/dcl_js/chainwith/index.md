---
layout: page
title: "dcl.chainWith()"
date: 2017-06-04 00:06
comments: false
sharing: true
footer: true
---

*Version 2.x*

This function declares how methods with a certain name should be chained. In most cases, end users do not use this function directly, opting for more declarative and easy to use alternatives: [dcl.chainBefore()](/2.x/docs/dcl_js/chainbefore/) and [dcl.chainAfter()](/2.x/docs/dcl_js/chainafter/).

## Description

`dcl.chainWith()` sets a chaining rule for a method. It takes three parameters:

* `Ctr` - the constructor function created by [dcl()](/2.x/docs/dcl_js/dcl/).
* `name` - the method name to be chained in `Ctr`'s prototype.
* `weaver` - the weaver object, which defines how chaining is done.

Following rules should be followed:

* It is impossible to "unchain" a chained method.
* It is impossible to change a chained method once it was set from "before" to "after" or in the opposite direction.
* Chaining should be declared only for base-less "classes".
* It is an error to mix "classes" with different chaining rules for the same method.
* It is possible to declare chaining for a method without actually declaring the method.

The function returns `true`, if it was able to define a required chaining, `false`, if a constructor was not defined by [dcl()](/2.x/docs/dcl_js/dcl/), and throws an error, if a chaining conflict was detected.

A weaver object has at least two named properties:

* `name` - the weaver's name.
* `weave` - the weaver function.

A weaver function is called in the context of a weaver object, and takes two parameters:

* `chains` - the array of property descriptions that correspond to a given method chain.
* `utils` - the object that defines numerous utilities to be used while weaving methods:
  * `adaptValue(f)` - adapts a function value by returning a getter for that value, or `null`.
  * `adaptGet(f)` - adapts a function getter by returning a function, which uses the getter to call its value as a function, or `null`.
  * `convertToValue(descriptor)` - converts a property `descriptor` from a getter to a value descriptor, or returns the old value `descriptor`.
  * `cloneDescriptor(descriptor)` - returns a shallow copy of `descriptor` flattening any prototypal inheritance in the process.
  * `augmentDescriptor(type, value)` - returns a function that takes a property descriptor, and sets `type` property on it to `value`, if it is not defined. If `value` a function, it is returned instead.
  * `augmentWritable(value)` - returns a function that takes a property descriptor, and sets `writable` property on it to `value`, if it is not defined. If `value` a function, it is returned instead.
  * `replaceDescriptor()`- returns a function that takes a property descriptor, and sets `type` property on it to `value`. If `value` a function, it is returned instead.
  * `replaceWritable()`- returns a function that takes a property descriptor, and sets `writable` property on it to `value`. If `value` a function, it is returned instead.
  
A weaver function should return a property descriptor, which will be defined for a given name on the final prototype.

## Notes

In general, this is a mechanism to define custom weavers to extend [dcl()](/2.x/docs/dcl_js/dcl/).

`dcl` defines following weaver objects:

* [dcl.weaveBefore](/2.x/docs/dcl_js/weavebefore/) - weaves chains using `before` method (the last one is called first). It is used by [dcl.chainBefore()](/2.x/docs/dcl_js/chainbefore/), and by `before` advices.
* [dcl.weaveAfter](/2.x/docs/dcl_js/weaveafter/) - weaves chains using `after` method (the first one is called first). It is used by [dcl.chainAfter()](/2.x/docs/dcl_js/chainafter/), and by `after` advices.
* [dcl.weaveSuper](/2.x/docs/dcl_js/weavesuper/) - weaves chains using `around` method (the last one is called first, and has a chance to call the next one in chain explicitly). It is used by super calls and `around` advices automatically (no need to specify it explicitly).
