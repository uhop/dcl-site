---
layout: page
title: "About"
date: 2012-07-21 13:03
comments: false
sharing: true
footer: true
---

A minimalistic yet complete JavaScript package for node.js and browsers that implements OOP with mixins + AOP at both
"class" and object level.

Highlights:

* Works in node.js and browsers, fully supports AMD.
* Implements C3 MRO to support a Python-like multiple inheritance.
* Targets object-oriented programming with mixins technology.
* Efficient supercalls &mdash; no run-time penalty, ultimate debuggability.
* Automatic constructor chaining, you can specify chaining for any method.
* Full support for AOP (before, around, after, after throwing advices).
* Comes with a mini library with some useful generic building blocks.
* Extensively tested, uses continuous integration with 85 automated tests.
* Fully compatible with the strict mode.

The package was written with debuggability of your code in mind. It comes with a special debug module that verifies
created objects, explains mistakes, and helps to keep track of AOP advices. Because the package uses direct static calls
to super methods, you don't need to step over unnecessary stubs. In places where stubs are unavoidable (chains or
advices) they are small, and intuitive.

If you migrate your code from a legacy framework that implements dynamic (rather than static) supercalls, take a look at
the module "inherited" that dispatches supercalls dynamically trading off the simplicity of the code for some run-time
CPU use, and a little bit less convenient debugging of such calls due to an extra stub between your methods.