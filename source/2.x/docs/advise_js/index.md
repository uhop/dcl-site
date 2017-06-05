---
layout: page
title: "advise.js"
date: 2012-07-21 13:21
comments: false
sharing: true
footer: true
---

`advise.js` provides general AOP facilities to advise object methods dynamically. Unlike [dcl.js][] it is not used
to weave methods of "classes", but works with objects.

It can be included with following commands:

{% codeblock Include advise lang:js %}
// node.js
var advise = require("dcl/advise");
...

// AMD (code)
require(["dcl/advise"], function(advise){
  ...
});

// AMD (definition)
define(["dcl/advise"], function(advise){
  ...
});
{% endcodeblock %}

## Module API

The return value of this module is a function, which is called `advise()` in this documentation.

[advise()](/docs/advise_js/advise) is an AOP composition engine. Additionally it hosts a raft of public properties.

Helpers:

* [advise.before()](/docs/advise_js/before) - *shortcut for a "before" advice*
* [advise.around()](/docs/advise_js/around) - *shortcut for an "around" advice*
* [advise.after()](/docs/advise_js/after) - *shortcut for an "after" advice*

Auxiliary properties:

* [advise.Node](/docs/advise_js/node) - *constructor used by [advise()](/docs/advise_js/advise) to advise a method*

[dcl.js]:  /docs/dcl_js  dcl.js
