---
layout: page
title: "About"
date: 2012-07-21 13:03
comments: false
sharing: true
footer: true
---

A minimalistic yet complete JavaScript package for [node.js][] and modern browsers.
It implements [OOP][] with [mixins](http://en.wikipedia.org/wiki/Mixins) + [AOP][]
at both "class" and object level.

The goal of `dcl` is to provide a sound [OOP][]/[AOP][] foundation for
projects of all sizes, while promoting the best practices to
keep user's codebase small and [DRY][].

It is a tool to structure a project as a set of small orthogonal mixins
glued together with supercalls, chaining, and advices leading to reducing
the overall codebase, and clear path to refactor the resulting project.

It is started by [Eugene Lazutkin](http://lazutkin.com/blog/),
and publicly available [on GitHub](https://github.com/uhop/dcl).

## Overview

* Works in [node.js][] and browsers, fully supports [AMD][].
  * Fully compatible with strict mode.
* Small codebase.
  * Easy to learn, easy to use.
  * Intentionally small set of orthogonal features.
* Extensively tested.
  * Uses [continuous integration](http://travis-ci.org/uhop/dcl) running
    111 automated tests.
* Liberally licensed.
  * Available under new [BSD][] or [AFL][] v2 &mdash; your choice.
  * Free for commercial and non-commercial use.
* Legally clean code.
  * Developed in the open.
  * All contributions are covered by CLA.

## Highlights

* Targets [OOP][] with mixins technology.
  * Supports a Python-like multiple inheritance (implements the same
    [C3 MRO algorithm](http://www.python.org/download/releases/2.3/mro/)).
  * Efficient [supercalls](/docs/mini_js/supercall) &mdash; no run-time penalty,
    ultimate debuggability.
  * Automatic constructor chaining, and you can specify chaining for any method.
* Full support for [AOP][] (before, around, after returning, and
  after throwing advices).
  * [AOP][] can be applied at "class" level (statically) or
    at object level (dynamically).
  * Dynamic advices can be unadvised at any time.
* Comes with a mini library of useful generic building blocks.

## Stress on debuggability

The package was written with debuggability of your code in mind. It comes with
a special debug module that verifies created objects, explains mistakes, and helps
to keep track of [AOP][] advices.

Because `dcl` uses direct static calls to super methods, you don't need
to step over unnecessary stubs. In places where stubs are unavoidable
(chains or advices) they are small, and intuitive.

## Installation

If you plan to use it in your [node.js][] project install it
like this:

{% codeblock %}
npm install dcl
{% endcodeblock %}

For your browser-based projects I suggest to use [volo.js][]:

{% codeblock %}
volo install -amd dcl
{% endcodeblock %}

You can find more details and instructions for some other package managers in
[Installation guide](/docs/installation).

Happy coding!

[node.js]:  http://nodejs.org   node.js
[volo.js]:  http://volojs.org   volo.js
[OOP]:      http://en.wikipedia.org/wiki/Object-oriented_programming
[AOP]:      http://en.wikipedia.org/wiki/Aspect-oriented_programming
[DRY]:      http://en.wikipedia.org/wiki/Don%27t_repeat_yourself
[AMD]:      http://en.wikipedia.org/wiki/Asynchronous_module_definition
[BSD]:      http://en.wikipedia.org/wiki/New_BSD
[AFL]:      http://en.wikipedia.org/wiki/Academic_Free_License
