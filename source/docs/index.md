---
layout: page
title: "Documentation"
date: 2012-07-21 13:19
comments: false
sharing: true
footer: true
---

`dcl` is a micro library written in JavaScript for [node.js](http://nodejs.org) and browsers that implements OOP with
mixins + AOP at both "class" and object level.

## Getting started

*This documentation is a work in progress.*

* [Tutorial](/docs/tutorial) - *hands-on with `dcl`*
* [Cheatsheet](/docs/cheatsheet) - *look up common operations*

## Module documentation

*This documentation is a work in progress.*

* [mini.js](/docs/mini) - *minimal `dcl` kernel, you might want to use it on browsers to conserve bandwidth*
  * [dcl()](/docs/mini/dcl) - *the composition engine*
  * [superCall()](/docs/mini/supercall) - *super call decorator*
  * [mix()](/docs/mini/mix) - *mix in one object with another*
  * [delegate()](/docs/mini/delegate) - *delegate from one object to another*
* [dcl.js](/docs/dcl) - *full `dcl` kernel that includes chaining control and AOP support*
  * [advise()](/docs/dcl/advise) - *general advice decorator*
  * [before()](/docs/dcl/before) - *"before" advice decorator*
  * [around()](/docs/dcl/around) - *"around" advice decorator*
  * [after()](/docs/dcl/after) - *"after" advice decorator*
  * [chainBefore()](/docs/dcl/chainbefore) - *"before" chaining directive*
  * [chainAfter()](/docs/dcl/chainafter) - *"after" chaining directive*
* [advise.js](/docs/advise) - *object-level AOP with dynamic advisement*
  * [advise()](/docs/advise/advise) - *general advice directive*
  * [before()](/docs/advise/before) - *"before" advice directive*
  * [around()](/docs/advise/around) - *"around" advice directive*
  * [after()](/docs/advise/after) - *"after" advice directive*
* [inherited.js](/docs/inherited) - *dynamic super calls without decorators*
  * [inherited()](/docs/inherited/inherited) - *super call*
* [debug.js](/docs/debug) - *error-checking and introspection facility*
  * [log()](/docs/debug/log) - *log information of classes and objects*

## Advanced topics

*This documentation is a work in progress.*

* [OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/) - *discussion of advanced OOP, its deficiencies, and
ways to overcome its problems*
* [OOP in JS slides](http://lazutkin.com/blog/2012/jul/17/oop-n-js-slides/) - *my presentation at
[ClubAjax](http://clubajax.org) partially based on the blog post above; dcl was introduced as an experiement to create
a balanced OOP + AOP package, which helps leverage mixin-based techniques*
