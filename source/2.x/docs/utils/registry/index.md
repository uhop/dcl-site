---
layout: page
title: "registry"
date: 2017-07-19 13:56
comments: false
sharing: true
footer: true
---

*Version 2.x*

`registry` plugs in to `dcl` and automatically register all new constructors using `declaredClass` property as a key. Users can access constructors by name, enumerate them, and clear the registry selectively by name, or whole.

It is defined in `dcl/utils/registry.js`.

## Description

`registry` returns a singleton with following API:

{% codeblock registry lang:js %}
{
  get:    function (name) {...},
  has:    function (name) {...},
  delete: function (name) {...},
  keys:   function () {...},
  clear:  function () {...}
}
{% endcodeblock %}

The registry is updated automatically every time new constructor is created with `dcl`, if it defines a name using `declaredClass` property.

### `get(name)`

`get(name)` takes a constructor name, and returns a constructor function, or `undefined`, if it is not found.

### `has(name)`

`has(name)` takes a constructor name, and returns `true`, if the registry contains such constructor, or `false` otherwise.

### `delete(name)`

`delete(name)` takes a constructor name, and deletes the corresponding constructor from the registry. The method returns `true`, if the operation was successful, or `false` otherwise.

### `keys()`

`keys()` returns an array of all constructor names in the registry.

### `clear()`

`clear()` purges the registry from all registered constructors.

## Examples

{% codeblock Using registry lang:js %}
var registry = require('dcl/utils/registry');

// ...

// enumerate all constructors
registry.keys().forEach(function (name) {
    var Ctr = registry.get(name);
    // do something with Ctr
  });

// delete all constructors that start with 'Debug'
registry.keys().
  filter(function (name) { return /^Debug/.test(name); }).
  forEach(function (name) {
    registry.delete(name);
  });
  
// access a constructor by name
if (registry.has('Component')) {
  var Component = registry.get('Component');
  var component = new Component();
  // use component
}

// remove all constructor registered so far
registry.clear();
console.log(registry.keys().length); // 0
{% endcodeblock %}
