---
layout: page
title: "Destroyable"
date: 2017-06-08 13:56
comments: false
sharing: true
footer: true
---

*Version 2.x*

`Destroyable` forces all methods called `destroy()` to be chained in the "before" fashion (opposite to constructors). It is meant to provide a destruction foundation, so objects can be destroyed explicitly in a unified fashion.

It is defined in `dcl/mixins/Destroyable.js`.

## Description

Here is its definition:

{% codeblock Destroyable lang:js %}
var Destroyable = dcl(null, {
  declaredClass: "dcl/mixins/Destroyable"
});
dcl.chainBefore(Destroyable, "destroy");
{% endcodeblock %}

As you can see it contains no code! The only important part is the chaining directive. When you mix it into your "classes" it will weave all found `destroy()` methods properly.

Read a background on destruction in [Destructors](/2.x/docs/general/destructors/).

## Examples

{% codeblock Destroyable example lang:js %}
var A = dcl(Destroyable, {
  declaredClass: "A",
  constructor: function () {
    // our controlled resource:
    this.node = document.createElement("div");
    // if we do not remove it from a document,
    // when deleting an instance, it will persist
    ...
  },
  destroy: function () {
    // we should remove our controlled resource
    // from a document
    if (this.node && this.node.parentNode) {
      this.node.parentNode.removeChild(this.node);
      this.node = null;
    }
  },
  ...
});
{% endcodeblock %}
