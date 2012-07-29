---
layout: page
title: "About"
date: 2012-07-21 13:03
comments: false
sharing: true
footer: true
---

A minimalistic yet complete JavaScript package for [node.js][] and browsers that implements OOP with
mixins + AOP at both "class" and object level.

## Overview

* Works in [node.js][] and browsers, fully supports AMD.
  * Fully compatible with the strict mode.
* Small codebase.
  * Easy to learn, easy to use.
  * Intentionally small set of orthogonal features.
* Extensively tested
  * Uses [continuous integration](http://travis-ci.org/uhop/dcl) running 85 automated tests.
* Liberally licensed.
  * Available under new BSD or AFLv2 &mdash; your choice.
* Legally clean code.
  * Developed in the open.
  * All contributions are covered by CLA.

## Highlights

* Targets OOP with mixins technology.
  * Supports a Python-like multiple inheritance (implements the same
    [C3 MRO algorithm](http://www.python.org/download/releases/2.3/mro/)).
  * Efficient supercalls &mdash; no run-time penalty, ultimate debuggability.
  * Automatic constructor chaining, and you can specify chaining for any method.
* Full support for AOP (before, around, after returning, and after throwing advices).
* Comes with a mini library of useful generic building blocks.

## Stress on debuggability

The package was written with debuggability of your code in mind. It comes with a special debug module that verifies
created objects, explains mistakes, and helps to keep track of AOP advices. Because the package uses direct static calls
to super methods, you don't need to step over unnecessary stubs. In places where stubs are unavoidable (chains or
advices) they are small, and intuitive.

<!--
If you migrate your code from a legacy framework that implements dynamic (rather than static) supercalls, take a look at
the module [inherited](/docs/inherited_js) that dispatches supercalls dynamically trading off the simplicity of the code
for some run-time CPU use, and a little bit less convenient debugging of such calls due to an extra stub between your
methods.
-->

[node.js]:  http://nodejs.org   node.js