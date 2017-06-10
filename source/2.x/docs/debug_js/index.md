---
layout: page
title: "debug.js"
date: 2017-06-09 13:21
comments: false
sharing: true
footer: true
---

*Version 2.x*

Debuggability is one of the main concerns for any public library. It should provide a concise picture of produced, yet it should not affect size nor performance of said library.

`debug.js` is a debug helper for `dcl`. It augments [dcl()](/2.x/docs/dcl_js/dcl/) with enhanced error reporting, and provides debugging helpers. This module was designed primarily to be used during development.

It is defined in `dcl/debug.js`. It adds properties to the main `dcl` module, which it returns.

## Module API

Main property:

* [dcl.log()](/2.x/docs/debug_js/log/) - *logs class and/or object metainformation to `console.log`*

Error object:

* [dcl.DclError](/2.x/docs/debug_js/dclerror/) - *the base for all errors*
* [dcl.CycleError](/2.x/docs/debug_js/cycleerror/) - *thrown when there is an unresolvable cycle in list of declared bases*
* [dcl.SuperError](/2.x/docs/debug_js/supererror/) - *thrown when the next-in-line property is not a function, and a super call cannot be made*
* [dcl.ChainingError](/2.x/docs/debug_js/chainingerror/) - *thrown when composing a class with different chaining directives for the same method*
