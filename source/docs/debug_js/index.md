---
layout: page
title: "debug.js"
date: 2012-07-21 13:21
comments: false
sharing: true
footer: true
---

`debug.js` is a debug helper for `dcl`. It augments [dcl()](/docs/mini_js/dcl) with enhanced error reporting, and
provides debugging helpers. This module was designed primarily to be used during development.

## Module API

The return value of this module is an object, which is called `dclDebug` in this documentation.

Main property:

* [dclDebug.log()](/docs/debug_js/log) - *logs class and/or object metainformation to `console.log`*

General error object:

* [dclDebug.DclError](/docs/debug_js/dclerror) - *the base for all errors*

"Class" composition error:

* [dclDebug.CycleError](/docs/debug_js/cycleerror) - *thrown when there is an unresolvable cycle in list of
  declared bases*

Supercall and around advice errors:

* [dclDebug.SuperCallError](/docs/debug_js/supercallerror) - *thrown when an argument of
  [dcl.superCall()](/docs/mini_js/supercall) or [dcl.around()](/docs/dcl_js/around) decorators is not a function*
* [dclDebug.SuperError](/docs/debug_js/supererror) - *thrown when the next-in-line property is not a function, and
  a super call cannot be made*
* [dclDebug.SuperResultError](/docs/debug_js/superresulterror) - *thrown when an argument of
  [dcl.superCall()](/docs/mini_js/supercall) or [dcl.around()](/docs/dcl_js/around) decorators does not return
  a function (likely the double function pattern was not followed &mdash; see [dcl.superCall()](/docs/mini_js/supercall)
  for details)*

Chaining errors:

* [dclDebug.ChainingError](/docs/debug_js/chainingerror) - *thrown when composing a class with different chaining
  directives for the same method*
* [dclDebug.SetChainingError](/docs/debug_js/setchainingerror) - *thrown when setting a conflicting chaining*
