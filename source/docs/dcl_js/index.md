---
layout: page
title: "dcl.js"
date: 2012-07-21 13:20
comments: false
sharing: true
footer: true
---

`dcl.js` is a standard kernel of `dcl`. It augments [mini.js][]. While [mini.js][] implements OOP facilities,
and supercalls, `dcl.js` adds AOP, chaining, and more utilities.

## Module API

The return value of this module is a function, which is called `dcl()` in this documentation.

[dcl()](/docs/mini_js/dcl) is the same function returned by [mini.js][], but augmented with new functionality and
new public properties.

Main properties:

* [dcl.advise()](/docs/dcl_js/advise) - *AOP advise decorator, used to weave methods*
* [dcl.chainBefore()](/docs/dcl_js/chainbefore) - *function to declare chaining "before" for a method*
* [dcl.chainAfter()](/docs/dcl_js/chainafter) - *function to declare chaining "after" for a method*

Helpers:

* [dcl.before()](/docs/dcl_js/before) - *shortcut for a "before" advice*
* [dcl.around()](/docs/dcl_js/around) - *shortcut for an "around" advice*
* [dcl.after()](/docs/dcl_js/after) - *shortcut for an "after" advice*

Utilities:

* [dcl.isInstanceOf()](/docs/dcl_js/isinstanceof) - *checks if an object is an instance of a constructor*

Auxiliary properties:

* [dcl.Advice](/docs/dcl_js/advice) - *constructor used by [dcl.advise()](/docs/dcl_js/advise) to create a decorator*

[mini.js]:  /docs/mini_js  mini.js
