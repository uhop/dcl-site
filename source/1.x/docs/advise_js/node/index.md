---
layout: page
title: "advise.Node"
date: 2012-07-29 00:04
comments: false
sharing: true
footer: true
---

*Version 1.x*

This is a constructor, which serves as a foundation of method weaving used by [advise()](../advise_js/advise).
It is not intended to be used by end-users, and useful only for extending `dcl` itself.

## Description

[advise()](../advise_js/advise) produces objects based on `advise.Node`. It is only useful for extending `dcl`.
Object with such prototype are used to build fast chains to weave advices.
