---
layout: page
title: "mini.js"
date: 2012-07-21 13:20
comments: false
sharing: true
footer: true
---

`mini.js` is a minimal kernel of `dcl`. It implements OOP facilities for single and
multiple inheritance using mixins, and super calls. Additionally it provides useful
utilities to work with objects.

There is a drop-in replacement for `mini.js` (added in `dcl` 1.1.0), which supports
legacy browsers (tested with IE8): [legacy.js](/docs/legacy_js). It has the same API,
and the same functionality. While it can be used instead of `mini.js` on modern
browsers, it is not recommended, because [legacy.js](/docs/legacy_js) is slower than
`mini.js`.

`mini.js` module can be included with following commands:

{% codeblock Include mini lang:js %}
// node.js
var dcl = require("dcl/mini");
...

// AMD (code)
require(["dcl/mini"], function(dcl){
  ...
});

// AMD (definition)
define(["dcl/mini"], function(dcl){
  ...
});
{% endcodeblock %}

## Module API

The return value of this module is a function, which is called `dcl()` in this documentation.

[dcl()](/docs/mini_js/dcl) is the main "class" composition engine. While it is important by itself, it hosts a number of
public properties.

Main properties:

* [dcl.superCall()](/docs/mini_js/supercall) - *super call decorator*

Utilities:

* [dcl.mix()](/docs/mini_js/mix) - *mix in one object with another*
* [dcl.delegate()](/docs/mini_js/delegate) - *delegate from one object to another*

Auxiliary properties:

* [dcl.Super](/docs/mini_js/super) - *constructor used by [dcl.superCall()](/docs/mini_js/supercall)
  to create a decorator*
