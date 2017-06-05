---
layout: page
title: "dcl.Super"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a constructor, which serves as a foundation of method decorators used by `dcl`. It is not intended to be
used by end-users, and useful only for extending `dcl` itself.

## Description

`dcl.Super` is a super-simple constructor, which creates objects with a single property `around`, which is assigned its constructor argument value. It is exposed solely for an introspection with `instanceof` by possible preprocessors for `dcl`.

By default a decorated method is represented by a function with a property named `spr`, which is an instance of `dcl.Super`. It is a purely transient feature, which is not present in fully constructed constructors nor objects.
