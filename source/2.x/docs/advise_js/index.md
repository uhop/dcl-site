---
layout: page
title: "advise.js"
date: 2017-06-05 13:21
comments: false
sharing: true
footer: true
---

*Version 2.x*

`advise.js` provides general AOP facilities to advise object methods dynamically. Unlike [dcl.js][] it is not used
to weave methods of "classes", but works with objects.

It is defined in `dcl/advise.js`.

## Module API

The return value of this module is a function, which is called `advise()` in this documentation.

* [advise()](./advise_js/advise) - *the AOP composition engine*

Additionally it hosts a raft of public properties.

### Helpers

* [advise.before()](./advise_js/before) - *shortcut for a "before" advice*
* [advise.after()](./advise_js/after) - *shortcut for an "after" advice*
* [advise.around()](./advise_js/around) - *shortcut for an "around" advice*

### Auxiliary properties

* [advise.Node](./advise_js/node) - *constructor used by [advise()](./advise_js/advise) to mark a method as advised*

[dcl.js]:  ./dcl_js  dcl.js
