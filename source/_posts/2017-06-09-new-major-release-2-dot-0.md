---
layout: post
title: "New major release: 2.0"
date: 2017-06-09 20:34:57 -0500
comments: true
categories: announce
---

New major release 2.0 for Node and ES5 browsers builds on 1.x branch, and adds following features:

* Simplified API.
* Supports ES5 features: getters, setters, generic property descriptors.
  * Internally all properties are defined using ES5 property descriptor API.
* Properties can be defined using the classic object notation, and the list of property descriptors.
* New decorator: `dcl.prop()`.
  * Property descriptors can be specified directly.
  * Getter and setters can be advised as easy as regular methods.
  * Supports "class"-wide defaults for `configurable`, `enumerable`, and `writable`.
* `detectProps` mode can detect property descriptors in-line without decorators.
* Node's `require()` import, and AMD are supported out of box.
* For convenience a version based on browser globals is provided.

<!-- more -->

At the same time it continues to support successful familiar features:

* Mixin-style OOP.
  * The same trusted and proven C3 MRO linearization algorithm for inherited mixins.
* Full set of AOP.
  * Supports "class" definitions.
  * Regular objects can be advised dynamically.
* The same library of useful advices, bases, and mixins.
* Special debugging facilities, which helped our users with tricky cases.
* Rigorously documented.

[Version 1.x](/1.x/docs/) is still supported and will continue to be available for legacy browsers.

Check out the [full documentation](/2.x/docs/). Use the [installation guide](/2.x/docs/installation/) to start using the new `dcl` in your projects.
