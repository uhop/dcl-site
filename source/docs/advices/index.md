---
layout: page
title: "Advices"
date: 2012-07-29 01:24
comments: false
sharing: true
footer: true
---

For programmer's convenience `dcl` provides following general advices:

* [counter](/docs/advices/counter) - *counts how many times a certain method was called
and how many times it failed (had thrown an exception)*
* [flow](/docs/advices/flow) - *classic AOP flow helper, which keeps track if we were
called in a process of executing of a certain method, and how many times it was recursed*
* [memoize](/docs/advices/memoize) - *another classic AOP helper, which provides simple
generic cache for read-only methods*
* [time](/docs/advices/time) - *timer, which uses `console` timing interface to measure
an execution time of a method*
* [trace](/docs/advices/trace) - *tracer, which logs `console` beginning and ending of
a method including its arguments, and a return value*
