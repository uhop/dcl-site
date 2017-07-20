---
layout: page
title: "Documentation 2.x"
date: 2017-06-04 13:19
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl` is a micro library written in JavaScript for [node.js](http://nodejs.org) and modern browsers that implements OOP with mixins + AOP at both "class" and object level.

Its repository is hosted at https://github.com/uhop/dcl -- version 2.x branch is called `dev2x`.

## Getting started

* [Installation](/2.x/docs/installation/) - *super-simple ways to install `dcl`*
* [Tutorial](/2.x/docs/tutorial/) - *hands-on with `dcl`*
* [Cheatsheet](/2.x/docs/cheatsheet/) - *look up common operations*
* [ChangeLog](/2.x/docs/changelog/) - *an official record of changes*

## Module documentation

* [dcl.js](/2.x/docs/dcl_js/) - *`dcl` kernel that includes chaining control and AOP support*
  * [dcl.superCall()](/2.x/docs/dcl_js/supercall/) - *super call decorator*
  * [dcl.advise()](/2.x/docs/dcl_js/advise/) - *general advice decorator, includes useful shortcuts:*
    * [dcl.before()](/2.x/docs/dcl_js/before/) - *"before" advice decorator*
    * [dcl.after()](/2.x/docs/dcl_js/after/) - *"after" advice decorator*
    * [dcl.around()](/2.x/docs/dcl_js/around/) - *"around" advice decorator*
  * *chaining directives:*
    * [dcl.chainBefore()](/2.x/docs/dcl_js/chainbefore/) - *"before" chaining directive*
    * [dcl.chainAfter()](/2.x/docs/dcl_js/chainafter/) - *"after" chaining directive*
  * *property directive:*
    * [dcl.prop()](/2.x/docs/dcl_js/prop/) - *custom property decorator, useful for getters/setters*
* [advise.js](/2.x/docs/advise_js/) - *object-level AOP with dynamic advisement*
  * [advise()](/2.x/docs/advise_js/advise/) - *general advice directive, includes useful shortcuts:*
    * [advise.before()](/2.x/docs/advise_js/before/) - *"before" advice decorator*
    * [advise.after()](/2.x/docs/advise_js/after/) - *"after" advice decorator*
    * [advise.around()](/2.x/docs/advise_js/around/) - *"around" advice decorator*
* [debug.js](/2.x/docs/debug_js/) - *error-checking and introspection facility*
  * [dcl.log()](/2.x/docs/debug_js/log/) - *log information of classes and objects*

## Library documentation

`dcl` comes with a small library of useful advices, mixins, and base classes:

* [Advices](/2.x/docs/advices/) - *various debugging, cache, and AOP helpers*
* [Bases](/2.x/docs/bases/) - *constructor helpers*
* [Mixins](/2.x/docs/mixins/) - *life-cycle helpers*
* [Utils](/2.x/docs/utils/) - *utilities*

## Advanced topics

* [Decorator](/2.x/docs/general/decorator/) - *explains the concept of decorators, and how they are used in `dcl`*
* [Supercalls in JS](/2.x/docs/general/supercalls/) - *discussion of different methods to do supercalls in JavaScript,
  their pros and cons, and what was selected for `dcl` and why*
* [Constructors](/2.x/docs/general/constructors/) - *desigining robust mixin-aware constructors*
* [Multi-stage construction](/2.x/docs/general/multi-stage-construction/) - *implementing multi-stage construction*
* [Destructors](/2.x/docs/general/destructors/) - *destructing objects and freeing its resources is a serious business*
* [OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/) - *discussion of advanced OOP, its deficiencies, and ways to overcome its problems*
* [OOP in JS slides](http://lazutkin.com/blog/2012/jul/17/oop-n-js-slides/) - *my presentation at [ClubAjax](http://clubajax.org) partially based on the blog post above; `dcl` was introduced as an experiment to create a balanced OOP + AOP package, which helps leverage mixin-based techniques*
