---
layout: page
title: "dcl.Advice"
date: 2017-06-04 00:06
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a constructor, which serves as a foundation of method decorators used by `dcl.advise()`.
It is not intended to be used by end-users, and useful only for extending `dcl` itself.

## Description

`dcl.advise()` produces objects based on `dcl.Advice`, which, in turn, is based from [dcl.Super](super).
It is exposed solely for an introspection with `instanceof` by possible preprocessors for `dcl`.

By default a `before` advice (if present) is exposed as a property `before` on a decorator object, an `after` advice as
a property `after`, and an `around` advice as a property `around`.

Instances of `dcl.Advice` are purely transient features, which are not present in fully constructed constructors nor objects.
