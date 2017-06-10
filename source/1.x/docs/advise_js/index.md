---
layout: page
title: "advise.js"
date: 2012-07-21 13:21
comments: false
sharing: true
footer: true
---

*Version 1.x*

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

[advise()](/1.x/docs/advise_js/advise/) is an AOP composition engine. Additionally it hosts a raft of public properties.

Helpers:

* [advise.before()](/1.x/docs/advise_js/before/) - *shortcut for a "before" advice*
* [advise.around()](/1.x/docs/advise_js/around/) - *shortcut for an "around" advice*
* [advise.after()](/1.x/docs/advise_js/after/) - *shortcut for an "after" advice*

Auxiliary properties:

* [advise.Node](/1.x/docs/advise_js/node/) - *constructor used by [advise()](/1.x/docs/advise_js/advise/) to advise a method*

[dcl.js]:  /1.x/docs/dcl_js/  dcl.js
