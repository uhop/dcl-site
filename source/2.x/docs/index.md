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

* [Installation](./docs/installation) - *super-simple ways to install `dcl`*
* [Tutorial](./docs/tutorial) - *hands-on with `dcl`*
* [Cheatsheet](./docs/cheatsheet) - *look up common operations*
* [ChangeLog](./docs/changelog) - *an official record of changes*

## Module documentation

* [dcl.js](./docs/dcl_js) - *`dcl` kernel that includes chaining control and AOP support*
  * [dcl.superCall()](./docs/dcl_js/supercall) - *super call decorator*
  * [dcl.advise()](./docs/dcl_js/advise) - *general advice decorator, includes useful shortcuts:*
    * [dcl.before()](./docs/dcl_js/before) - *"before" advice decorator*
    * [dcl.after()](./docs/dcl_js/after) - *"after" advice decorator*
    * [dcl.around()](./docs/dcl_js/around) - *"around" advice decorator*
  * *chaining directives:*
    * [dcl.chainBefore()](./docs/dcl_js/chainbefore) - *"before" chaining directive*
    * [dcl.chainAfter()](./docs/dcl_js/chainafter) - *"after" chaining directive*
  * *property directive:*
    * [dcl.prop()](./docs/dcl_js/prop) - *custom property decorator, useful for getters/setters*
* [advise.js](./docs/advise_js) - *object-level AOP with dynamic advisement*
  * [advise()](./docs/advise_js/advise) - *general advice directive, includes useful shortcuts:*
    * [advise.before()](./docs/advise_js/before) - *"before" advice decorator*
    * [advise.after()](./docs/advise_js/after) - *"after" advice decorator*
    * [advise.around()](./docs/advise_js/around) - *"around" advice decorator*
* [debug.js](./docs/debug_js) - *error-checking and introspection facility*
  * [dcl.log()](./docs/debug_js/log) - *log information of classes and objects*

## Library documentation

`dcl` comes with a small library of useful advices, mixins, and base classes:

* [Advices](./docs/advices) - *various debugging, cache, and AOP helpers*
* [Bases](./docs/bases) - *constructor helpers*
* [Mixins](./docs/mixins) - *life-cycle helpers*

## Advanced topics

* [Decorator](./docs/general/decorator) - *explains the concept of decorators, and how they are used in `dcl`*
* [Supercalls in JS](./docs/general/supercalls) - *discussion of different methods to do supercalls in JavaScript,
  their pros and cons, and what was selected for `dcl` and why*
* [Constructors](./docs/general/constructors) - *desigining robust mixin-aware constructors*
* [Multi-stage construction](./docs/general/multi-stage-construction) - *implementing multi-stage construction*
* [Destructors](./docs/general/destructors) - *destructing objects and freeing its resources is a serious business*
* [OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/) - *discussion of advanced OOP, its deficiencies,
  and ways to overcome its problems*
* [OOP in JS slides](http://lazutkin.com/blog/2012/jul/17/oop-n-js-slides/) - *my presentation at
  [ClubAjax](http://clubajax.org) partially based on the blog post above; `dcl` was introduced as an experiment
  to create a balanced OOP + AOP package, which helps leverage mixin-based techniques*
