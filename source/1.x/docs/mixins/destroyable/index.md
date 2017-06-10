---
layout: page
title: "Destroyable"
date: 2012-07-29 13:56
comments: false
sharing: true
footer: true
---

*Version 1.x*

`Destroyable` forces all methods called `destroy()` to be chained in
the "before" fashion (opposite to constructors). It is meant to provide
a destruction foundation, so objects can be destroyed explicitly in
a unified fashion.

It can be included with following commands:

{% codeblock Include Destroyable lang:js %}
// node.js
var Destroyable = require("dcl/mixins/Destroyable");
...

// AMD (code)
require(["dcl/mixins/Destroyable"], function(Destroyable){
  ...
});

// AMD (definition)
define(["dcl/mixins/Destroyable"], function(Destroyable){
  ...
});
{% endcodeblock %}

## Description

Here is its definition:

{% codeblock Destroyable lang:js %}
var Destroyable = dcl(null, {
  declaredClass: "dcl/mixins/Destroyable"
});
dcl.chainBefore(Destroyable, "destroy");
{% endcodeblock %}

As you can see it contains no code! The only important part is a chaining directive.
When you mix it in to your "classes" it will weave all found `destroy()` methods
properly.

Read a background on destruction in [Destructors](/1.x/docs/general/destructors/).

## Examples

{% codeblock Destroyable example lang:js %}
var A = dcl(Destroyable, {
  declaredClass: "A",
  constructor: function(){
    // our controlled resource:
    this.node = document.createElement("div");
    // if we do not remove it from a document,
    // when deleting an instance, it will persist
    ...
  },
  destroy: function(){
    // we should remove our controlled resource
    // from a document
  	if(this.node && this.node.parentNode){
      this.node.parentNode.removeChild(this.node);
      this.node = null;
    }
  },
  ...
});
{% endcodeblock %}
