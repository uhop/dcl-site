---
layout: page
title: "dcl.getPropertyDescriptor()"
date: 2017-06-04 00:06
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.getPropertyDescriptor()` is modeled after [Object.getOwnPropertyDescriptor()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/getOwnPropertyDescriptor). The difference is that the latter retrieves a property descriptor for the own property, while the former looks through an inheritance chain, and can retrieve a property descriptor for the inherited property.

## Description

Just like [Object.getOwnPropertyDescriptor()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/getOwnPropertyDescriptor) `dcl.getPropertyDescriptor()` takes two parameters:

* `obj` - the object to inspect.
* `name` - the name of the property whose property descriptor should be retrieved.

The utility returns a property descriptor object or `undefined`, if the property is missing.
