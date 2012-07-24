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

[dcl()](/docs/mini/dcl) is the main "class" composition engine. While it is important by itself, it hosts a number of
public properties.

Main properties:

* [superCall()](/docs/mini/supercall) - *super call decorator*
* [mix()](/docs/mini/mix) - *mix in one object with another*
* [delegate()](/docs/mini/delegate) - *delegate from one object to another*

Auxiliary properties:

* [Super](/docs/mini/super) - *constructor used by [superCall()](/docs/mini/supercall) to create a decorator*
