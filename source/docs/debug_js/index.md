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

Main properties:

* [dclDebug.log()](/docs/debug_js/log) - *logs class and/or object metainformation to `console.log`*

Auxiliary properties:

* [dclDebug.Error](/docs/debug_js/error) - *the base for all errors*
* [dclDebug.ChainingError](/docs/debug_js/chainingerror) - *thrown when composing a class with different chaining
  directives for the same method*
* [dclDebug.SetChainingError](/docs/debug_js/setchainingerror) - *thrown when setting a conflicting chaining*
* [dclDebug.CycleError](/docs/debug_js/cycleerror) - *thrown when there is an unresolvable cycle in list of
  declared bases*
