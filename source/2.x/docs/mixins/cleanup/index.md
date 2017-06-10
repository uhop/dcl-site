---
layout: page
title: "Cleanup"
date: 2017-06-08 13:56
comments: false
sharing: true
footer: true
---

*Version 2.x*

`Cleanup` is an elaborate facility to handle cleanups for multiple dependent objects even in completely dynamic environments. It is built on [Destroyable](/2.x/docs/mixins/destroyable/), and can consume other objects, which support `Destroyable` protocol: define `destroy()` method.

It is defined in `dcl/mixins/Cleanup.js`.

## Description

Read a background on destruction in [Destructors](/2.x/docs/general/destructors/).

`Cleanup` defines following API:

{% codeblock Cleanup lang:js %}
var Cleanup = dcl(Destroyable, {
  declaredClass: "dcl/mixins/Cleanup",
  constructor: function () {...},
  pushCleanup: function (resource, cleanup) {...},
  popCleanup: function (dontRun) {...},
  removeCleanup: function (f) {...},
  cleanup: function () {...},
  destroy: function () {
    this.cleanup();
  }
});
{% endcodeblock %}

The whole system operates in a stack-like fashion reflecting common embedded states.

### Constructor

Constructor initializes an internal state required for `Cleanup` to function. It creates a single property on an instance called `__cleanupStack`.

### `pushCleanup(resource, cleanup)`

`pushCleanup()` and `popCleanup()` operate in a [LIFO](http://en.wikipedia.org/wiki/LIFO) fashion. `resource` is any resource you want to keep track of. `cleanup` is an optional function, which can be used to dispose of `resource`. During the cleanup phase:

1. If `cleanup` was present, it is called passing `resource` as the only parameter.
2. If `cleanup` was not present, it is assumed that `resource` supports [Destroyable](/2.x/docs/dcl_js/destroyable/) protocol, and its `destroy()` method will be called.

`pushCleanup()` returns a function object that uniquely identifies the pushed resource. It can be used later with `removeCleanup()`.

Additionally it can be called without parameters to clean up the resource. Please do so only after it was successfully removed with `removeCleanup()`.

### `popCleanup(dontRun)`

`popCleanup()` is a counterpart of `pushCleanup()`. It runs a cleanup code for the last pushed resource returning nothing. If `dontRun` is a truthy value, the cleanup run is skipped, and the last object is simply removed from stack and the function to clean it up is returned.

If you poped a cleanup resource manually with this method passing a truthy value as `dontRun`, you are responsible for cleaning it up manually. One way to do it is to call the returned value as a function with no parameters.

### `removeCleanup(f)`

This method is used to remove a reference to a resource from the stack. It can be anywhere. The cleanup code for that resource is not run.

The only parameter for this method is a value returned by `pushCleanup()`.

The method returns a truthy value, if the resource was found, and a falsy value otherwise. If you know that resource was pushed, but it is not there, usually it means that it was already cleaned up.

If you removed a cleanup resource manually with this method, you are responsible for cleaning it up manually. One way to do it is to call `f` as a function with no parameters.

### `cleanup()`

Cleans up all accumulated resources removing them from the stack.

### `destroy()`

A required method for [Destroyable](/2.x/docs/dcl_js/destroyable/) protocol. It simply calls `cleanup()`.

## Examples

{% codeblock Cleanup example lang:js %}
var ManagedNode = dcl(Destroyable, {
  declaredClass: "ManagedNode",
  constructor: function () {
    this.node = document.createElement("div");
  },
  destroy: function () {
  	if(this.node && this.node.parentNode){
      this.node.parentNode.removeChild(this.node);
      this.node = null;
    }
  },
  ...
});

var Fragment = dcl(Cleanup, {
  declaredClass: "Fragment",
  constructor: function () {
    this.root = new ManagedNode();
    this.pushCleanup(this.root);
    // this.root is automatically removed
    // when object is destroyed by destroy()
    document.appendChild(this.root.node);
  },
  flashText: function (text) {
    var rawNode = document.createElement("h1");
    rawNode.innerHTML = text;
    this.root.node.appendChild(rawNode);
    var f = this.pushCleanup(rawNode, function (node) {
      node.parentNode.removeChild(node);
    });
    var self = this;
    setTimeout(function () {
      // remove our resource manually,
      // if it is still there
      if (self.removeCleanup(f)) {
        f();
      }
    }, 1000);
  }
});

var fragment = new Fragment();
...
fragment.flashText("Hello!");
...
fragment.destroy();
{% endcodeblock %}
