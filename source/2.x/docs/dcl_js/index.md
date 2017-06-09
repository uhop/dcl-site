---
layout: page
title: "dcl.js"
date: 2017-06-04 13:20
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.js` is a standard kernel of `dcl`. It implements OOP facilities, supercalls, AOP, chaining, and more utilities.

It is defined in `dcl/dcl.js`, but being the main module can be available directly from `dcl`.

## Module API

The return value of this module is a function, which is called `dcl()` in this documentation.

* [dcl()](./dcl_js/dcl) - *the main "class" composition engine*

While it is important by itself, it hosts a number of public properties.

### Main properties

* Super calls and AOP:
  * [dcl.superCall()](./dcl_js/supercall) - *super call decorator*
  * [dcl.advise()](./dcl_js/advise) - *AOP advise decorator, used to weave methods*
  * Helpers:
    * [dcl.before()](./dcl_js/before) - *shortcut for a "before" advice*
    * [dcl.after()](./dcl_js/after) - *shortcut for an "after" advice*
    * [dcl.around()](./dcl_js/around) - *shortcut for an "around" advice (synonym for [dcl.superCall()](../docs/dcl_js/supercall))*
* Chaining:
  * [dcl.chainWith()](./dcl_js/chainwith) - *function to declare chaining with a weaver for a method*
  * Helpers:
    * [dcl.chainBefore()](./dcl_js/chainbefore) - *function to declare chaining "before" for a method*
    * [dcl.chainAfter()](./dcl_js/chainafter) - *function to declare chaining "after" for a method*
* Properties:
  * [dcl.prop()](./dcl_js/prop) - *custom property decorator, useful for getters/setters*

### Utilities

* [dcl.isInstanceOf()](./dcl_js/isinstanceof) - *checks if an object is an instance of a constructor*

### Auxiliary properties

* Super calls and AOP:
  * [dcl.Super](./dcl_js/super) - *constructor used by [dcl.superCall()](./dcl_js/supercall) to create a decorator*
  * [dcl.isSuper()](./dcl_js/issuper) - *introspection helper to find a "super" property*
  * [dcl.Advice](./dcl_js/advice) - *constructor used by [dcl.advise()](./dcl_js/advise) to create a decorator*
* Chaining:
  * [dcl.weaveBefore](./dcl_js/weavebefore) - *weaver to chain methods using "before" algorithm*
  * [dcl.weaveAfter](./dcl_js/weaveafter) - *weaver to chain methods using "after" algorithm*
  * [dcl.weaveSuper](./dcl_js/weavesuper) - *weaver to chain methods using "super" algorithm*
* Properties:
  * [dcl.Prop](./dcl_js/prop) - *constructor used by `dcl.prop()` to create a decorator*
  * [dcl.getPropertyDescriptor()](./dcl_js/getpropertydescriptor) - *finds a property descriptor across prototypes*
  * [dcl.collectPropertyDescriptors()](./dcl_js/collectpropertydescriptors) - *collects property descriptors for an object across prototypes*
