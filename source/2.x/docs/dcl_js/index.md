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

* [dcl()](/2.x/docs/dcl_js/dcl/) - *the main "class" composition engine*

While it is important by itself, it hosts a number of public properties.

### Main properties

* Super calls and AOP:
  * [dcl.superCall()](/2.x/docs/dcl_js/supercall/) - *super call decorator*
  * [dcl.advise()](/2.x/docs/dcl_js/advise/) - *AOP advise decorator, used to weave methods*
  * Helpers:
    * [dcl.before()](/2.x/docs/dcl_js/before/) - *shortcut for a "before" advice*
    * [dcl.after()](/2.x/docs/dcl_js/after/) - *shortcut for an "after" advice*
    * [dcl.around()](/2.x/docs/dcl_js/around/) - *shortcut for an "around" advice (synonym for [dcl.superCall()](/2.x/docs/dcl_js/supercall/))*
* Chaining:
  * [dcl.chainWith()](/2.x/docs/dcl_js/chainwith/) - *function to declare chaining with a weaver for a method*
  * Helpers:
    * [dcl.chainBefore()](/2.x/docs/dcl_js/chainbefore/) - *function to declare chaining "before" for a method*
    * [dcl.chainAfter()](/2.x/docs/dcl_js/chainafter/) - *function to declare chaining "after" for a method*
* Properties:
  * [dcl.prop()](/2.x/docs/dcl_js/prop/) - *custom property decorator, useful for getters/setters*

### Utilities

* [dcl.isInstanceOf()](/2.x/docs/dcl_js/isinstanceof/) - *checks if an object is an instance of a constructor*

### Auxiliary properties

* Super calls and AOP:
  * [dcl.Super](/2.x/docs/dcl_js/super/) - *constructor used by [dcl.superCall()](/2.x/docs/dcl_js/supercall/) to create a decorator*
  * [dcl.isSuper()](/2.x/docs/dcl_js/issuper/) - *introspection helper to find a "super" property*
  * [dcl.Advice](/2.x/docs/dcl_js/advice/) - *constructor used by [dcl.advise()](/2.x/docs/dcl_js/advise/) to create a decorator*
* Chaining:
  * [dcl.weaveBefore](/2.x/docs/dcl_js/weavebefore/) - *weaver to chain methods using "before" algorithm*
  * [dcl.weaveAfter](/2.x/docs/dcl_js/weaveafter/) - *weaver to chain methods using "after" algorithm*
  * [dcl.weaveSuper](/2.x/docs/dcl_js/weavesuper/) - *weaver to chain methods using "super" algorithm*
* Properties:
  * [dcl.Prop](/2.x/docs/dcl_js/prop/) - *constructor used by `dcl.prop()` to create a decorator*
  * [dcl.getPropertyDescriptor()](/2.x/docs/dcl_js/getpropertydescriptor/) - *finds a property descriptor across prototypes*
  * [dcl.collectPropertyDescriptors()](/2.x/docs/dcl_js/collectpropertydescriptors/) - *collects property descriptors for an object across prototypes*
