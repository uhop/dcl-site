---
layout: post
title: "New addition: registry"
date: 2017-07-19 23:07:07 -0500
comments: true
categories: announce
---

New utility was added to `dcl` in 2.0.2: [registry](/2.x/docs/utils/registry/).

Registry automatically collects all newly-declared constructors, if they define `declaredClass` property. Later they can be accessed by names. This feature is useful to decouple a declaration of a constructor from places that use it, and for debugging purposes. It provides a [Map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map)-like API, so users can inspect and manipulate the registry.

<!-- more -->

{% codeblock Examples of using registry lang:js %}
var registry = require('dcl/utils/registry');

// next constructor will be registered automatically
var A = dcl({
    declaredClass: 'A'
    // ...
  });
console.log(registry.has('A'));    // true

var A2 = registry.get('A');
console.log(A === A2);             // true

// let's register more
var B = dcl(A, {
    declaredClass: 'B'
    // ...
  });
  
// let's inspect the registry
var keys = registry.keys();
console.log('We have', keys.length,
  'registered classes:', keys.join(', '));

var b = new (registry.get('B'))();

// let's unregister A
console.log(registry.delete('A')); // true

// let's unregister all constructors
registry.clear();
{% endcodeblock %}
