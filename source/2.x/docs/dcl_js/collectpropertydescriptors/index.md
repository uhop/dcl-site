---
layout: page
title: "dcl.collectPropertyDescriptors()"
date: 2017-06-04 00:06
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.collectPropertyDescriptors()` is partially modeled after [Object.getOwnPropertyDescriptors()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/getOwnPropertyDescriptors). The difference is that the latter retrieves all own property descriptors, while the former collects all property descriptors through an inheritance chain, and fills with them the supplied object.

## Description

`dcl.collectPropertyDescriptors()` takes two parameters:

* `props` - the object to add property descriptors to.
* `obj` - the object to inspect.

For convenience, the utility returns `props`.
