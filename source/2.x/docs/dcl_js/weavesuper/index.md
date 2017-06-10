---
layout: page
title: "dcl.weaveSuper"
date: 2017-06-04 00:06
comments: false
sharing: true
footer: true
---

*Version 2.x*

It is a weaver object, which defines how to chain using `around` method (the last one is called first, and has a chance to call the next one in chain explicitly). It is used by super calls and `around` advices.

See [dcl.chainWith()](/2.x/docs/dcl_js/chainwith/) for more information on weaver objects.

This object is not for direct use by end users. It is exposed solely to extend `dcl`.
