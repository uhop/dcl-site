---
layout: page
title: "Decorator"
date: 2017-06-08 23:57
comments: false
sharing: true
footer: true
---

*Version 2.x*

Decorator is a function that can transform/augment objects, classes, or methods dynamically adding new functionality to them. Decorator is a useful tool of meta-programming, and used extensively in different programming languages.

`dcl` uses method decorators so we will concentrate on them.

## Concept

In general a method decorator is a function that receives a function, optional parameters, and return a new function (or the same but updated). The goal is to modify its behavior in a predictable generic way. So essentially a decorator looks like that:

{% codeblock Generic method decorator lang:js %}
var f = function (...) {...};
f = decorator(f);

// or more frequently you can see them like that:
A.prototype.f = decorator(function(...) {
  ...
});
{% endcodeblock %}

## Examples

### Transaction

Let's assume that there is a global transaction and we want to implement a simple transaction management for our database-aware functions/methods:

{% codeblock Transaction decorator lang:js %}
// assumptions:
// - global variable `currentTransaction`
// - global constructor `Transaction`

function transactionDecorator (f) {
  return function () {
    if (currentTransaction) {
      // our transaction is already managed: skip
      return f.apply(this, arguments);
    }
    // otherwise:
    currentTransaction = new Transaction();
    try {
      var result = f.apply(this, arguments);
      currentTransaction.commit();
      return result;
    } catch (e) {
      currentTransaction.rollback();
      throw e;
    } finally {
      currentTransaction = null;
    }
  };
}
{% endcodeblock %}

### Tracing

Note: we do not handle exceptions below for simplicity.

{% codeblock Tracing decorator lang:js %}
function tracingDecorator (f, name) {
  var level = 0;
  return function () {
    console.log(level++, ": entering ", name);
    var result = f.apply(this, arguments);
    console.log(--level, ": exiting ", name);
    return result;
}
{% endcodeblock %}

With this decorator we can trace when a controlled method is called, and if it calls itself recursively directly or indirectly.

### Pre- or post-processing

We may want to normalize input or output of a function in a predictable way. A postprocessing example, which converts non-string objects to JSON:

{% codeblock Postprocessing decorator 1 lang:js %}
function postDecorator (f) {
  return function () {
    var result = f.apply(this, arguments);
    if (typeof result == "string") {
      return result;
    }
    return JSON.stringify(result);
}
{% endcodeblock %}

Now we can build on this functionality. For example, we can add a JSONP callback, if it is requested in parameters:

{% codeblock Postprocessing decorator 2 lang:js %}
function postDecorator (f) {
  return function (params) {
    var result = f.apply(this, arguments);
    if (typeof result == "string") {
      return result;
    }
    var json = JSON.stringify(result);
    if (params.callback) {
      // JSONP
      return "(" + params.callback + ")(" + json + ")";
    }
    return json;
}
{% endcodeblock %}

Similarly we can add different formatters, like XML, and so on. The important idea here is that we can do it orthogonally in one place.

## Decorators in `dcl`

While `dcl` can work with classic method decorators, decorators for supercalls, or advices do not return a function. Instead they return an object with meta-information, which is used later to assemble objects producing required functions and methods.

All such objects are based on [dcl.Super](/2.x/docs/dcl_js/super/).

Now if you see a code like this:

{% codeblock dcl decorators lang:js %}
var A = dcl(B, {
  m1: dcl.superCall(function (sup) {
    return function (...) {
      ...
    }
  }),
  m2: dcl.after(function (...) {
    ...
  })
});
{% endcodeblock %}

You know that these are not some magic, but simple functions that communicate to `dcl` how you want to assemble objects.
