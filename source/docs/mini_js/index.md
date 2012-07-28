---
layout: page
title: "mini.js"
date: 2012-07-21 13:20
comments: false
sharing: true
footer: true
---

`mini.js` is a minimal kernel of `dcl`. It implements OOP facilities for single and multiple inheritance using mixins,
and super calls. Additionally it provides useful utilities to work with objects.

## Module API

The return value of this module is a function, which in this documentation it is called `dcl()`.

[dcl()](/docs/mini_js/dcl) is the main "class" composition engine. While it is important by itself, it hosts a number of
public properties.

Main properties:

* [superCall()](/docs/mini_js/supercall) - *super call decorator*

Utilities:

* [mix()](/docs/mini_js/mix) - *mix in one object with another*
* [delegate()](/docs/mini_js/delegate) - *delegate from one object to another*

Auxiliary properties:

* [Super](/docs/mini_js/super) - *constructor used by [superCall()](/docs/mini_js/supercall) to create a decorator*
