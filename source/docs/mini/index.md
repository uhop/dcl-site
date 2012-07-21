---
layout: page
title: "Module mini.js"
date: 2012-07-21 13:20
comments: false
sharing: true
footer: true
---

mini.js is a minimal kernel of dcl. It implements C3 MRO to linearize bases, and super calls. Additionally it provides
useful utilities to work with objects.

## Public properties

Main properties:

* [dcl()](/docs/mini/dcl) - *the composition engine*
* [superCall()](/docs/mini/supercall) - *super call decorator*
* [mix()](/docs/mini/mix) - *mix in one object with another*
* [delegate()](/docs/mini/delegate) - *delegate from one object to another*

Additionally it exposes these properties:

* [Super](/docs/mini/super) - *constructor used by [superCall()](/docs/mini/supercall) to create a decorator*
