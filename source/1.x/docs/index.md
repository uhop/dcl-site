---
layout: page
title: "Documentation 1.x"
date: 2012-07-21 13:19
comments: false
sharing: true
footer: true
---

*Version 1.x*

`dcl` is a micro library written in JavaScript for [node.js](http://nodejs.org)
and modern browsers that implements OOP with mixins + AOP at both "class" and
object level.

Its repository is hosted at https://github.com/uhop/dcl -- version 1.x branch is called `dev1x`.

## Getting started

* [Installation](/1.x/docs/installation/) - *super-simple ways to install `dcl`*
* [Tutorial](/1.x/docs/tutorial/) - *hands-on with `dcl`*
* [Cheatsheet](/1.x/docs/cheatsheet/) - *look up common operations*
* [ChangeLog](/1.x/docs/changelog/) - *an official record of changes*

## Module documentation

* [mini.js](/1.x/docs/mini_js/) - *minimal `dcl` kernel, you might want to use it
on browsers to conserve bandwidth*
  * [dcl()](/1.x/docs/mini_js/dcl/) - *the composition engine*
  * [dcl.superCall()](/1.x/docs/mini_js/supercall/) - *super call decorator*
* [dcl.js](/1.x/docs/dcl_js/) - *full `dcl` kernel that includes chaining control and
AOP support*
  * [dcl.advise()](/1.x/docs/dcl_js/advise/) - *general advice decorator, includes useful shortcuts:*
    * [dcl.before()](/1.x/docs/dcl_js/before/) - *"before" advice decorator*
    * [dcl.after()](/1.x/docs/dcl_js/after/) - *"after" advice decorator*
    * [dcl.around()](/1.x/docs/dcl_js/around/) - *"around" advice decorator*
  * *chaining directives:*
    * [dcl.chainBefore()](/1.x/docs/dcl_js/chainbefore/) - *"before" chaining directive*
    * [dcl.chainAfter()](/1.x/docs/dcl_js/chainafter/) - *"after" chaining directive*
* [advise.js](/1.x/docs/advise_js/) - *object-level AOP with dynamic advisement*
  * [advise()](/1.x/docs/advise_js/advise/) - *general advice directive, includes useful shortcuts:*
    * [advise.before()](/1.x/docs/advise_js/before/) - *"before" advice decorator*
    * [advise.after()](/1.x/docs/advise_js/after/) - *"after" advice decorator*
    * [advise.around()](/1.x/docs/advise_js/around/) - *"around" advice decorator*
* [inherited.js](/1.x/docs/inherited_js/) - *dynamic super calls without decorators*
  * [inherited()](/1.x/docs/inherited_js/inherited/) - *super call*
* [debug.js](/1.x/docs/debug_js/) - *error-checking and introspection facility*
  * [dclDebug.log()](/1.x/docs/debug_js/log/) - *log information of classes and objects*
* [legacy.js](/1.x/docs/legacy_js/) - *support for legacy browsers*

## Library documentation

`dcl` comes with a small library of useful advices, mixins, and base classes:

* [Advices](/1.x/docs/advices/) - *various debugging, cache, and AOP helpers*
* [Bases](/1.x/docs/bases/) - *constructor helpers*
* [Mixins](/1.x/docs/mixins/) - *life-cycle helpers*

## Advanced topics

* [Decorator](/1.x/docs/general/decorator/) - *explains the concept of decorators, and how they are used in `dcl`*
* [Supercalls in JS](/1.x/docs/general/supercalls/) - *discussion of different methods to do supercalls in JavaScript,
  their pros and cons, and what was selected for `dcl` and why*
* [Constructors](/1.x/docs/general/constructors/) - *desigining robust mixin-aware constructors*
* [Multi-stage construction](/1.x/docs/general/multi-stage-construction/) - *implementing multi-stage construction*
* [Destructors](/1.x/docs/general/destructors/) - *destructing objects and freeing its resources is a serious business*
* [OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/) - *discussion of advanced OOP, its deficiencies,
  and ways to overcome its problems*
* [OOP in JS slides](http://lazutkin.com/blog/2012/jul/17/oop-n-js-slides/) - *my presentation at
  [ClubAjax](http://clubajax.org) partially based on the blog post above; `dcl` was introduced as an experiment
  to create a balanced OOP + AOP package, which helps leverage mixin-based techniques*
