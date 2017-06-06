---
layout: page
title: "advise.Node"
date: 2017-06-05 00:04
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a constructor, which serves as a foundation of method weaving used by [advise()](advise).
It is not intended to be used by end-users, and useful only for extending `dcl` itself.

## Description

[advise()](advise) produces objects based on `advise.Node`. It is only useful for extending `dcl`.
Object with such prototype are used to build fast chains to weave advices.
