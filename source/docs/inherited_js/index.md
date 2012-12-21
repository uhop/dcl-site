---
layout: page
title: "inherited.js"
date: 2012-07-21 13:21
comments: false
sharing: true
footer: true
---

`inherited.js` is a dynamic dispatcher of supercalls. It augments
[dcl()](/docs/mini_js/dcl), and adds `inherited()` method to all newly created objects.

All facilities of `inherited.js` work in strict mode too.

It can be included with following commands:

{% codeblock Include inherited lang:js %}
// node.js
var inherited = require("dcl/inherited");
...

// AMD (code)
require(["dcl/inherited"], function(inherited){
  ...
});

// AMD (definition)
define(["dcl/inherited"], function(inherited){
  ...
});
{% endcodeblock %}

## Module API

The return value of this module is a function, which is called `inherited()` in this documentation. Note that the module value itself is usually not used directly, because
all principal functions are automatically mixed in an instance as methods.

[inherited()](/docs/inherited_js/inherited) is a dynamic dispatcher of supercalls,
and the main function of the module.
The same function is mixed in all newly created objects as `inherited`, and
exposed publicly as `dcl.inherited()`. Additionally it hosts some public properties.

Main properties:

* [getInherited()](/docs/inherited_js/getinherited) - *gets next-in-line super method dynamically*
* [inherited.get()](/docs/inherited_js/get) - *alias for [getInherited()](/docs/inherited_js/getinherited) on [inherited()](/docs/inherited_js/inherited)*
