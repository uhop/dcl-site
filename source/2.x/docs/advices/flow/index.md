---
layout: page
title: "flow"
date: 2017-06-08 13:54
comments: false
sharing: true
footer: true
---

*Version 2.x*

`flow` returns an instance of an object, which can be used as an AOP advice to track control flow. It can indicate if a certain method was called while in a control flow of another method.

This advice can be used for debugging, and for implementing flow-specific behavior.

It is defined in `dcl/advices/flow.js`.

## Description

This module allows to mark a flow (calls to specific methods) with a unique name, and check if those methods were part of our call stack at the moment. Additionally it provides counters to see how many times those methods were called in this flow to detect recursions.

For example, we can define two distinct flows that are triggered by different methods to collect information, and to distribute it. Other methods that are called in the flow of those trigger methods, can detect what is going on, and behave differently in different flows. One good examples is a flow-specific profiling, when we run counters and timers only for specific types of flow.

This is an API of `flow` module:

{% codeblock flow lang:js %}
var flow = {
  advice:   function (name) {...},
  inFlowOf: function (name) {...},
  getStack: function () {...},
  getCount: function () {...}
};
{% endcodeblock %}

### `advice(name)`

Returns an advice object, which marks a call to a method with a flow `name`. It can be used directly with [dcl.advise()](/2.x/docs/dcl_js/advise/) or [advise()](/2.x/docs/advise_js/advise/).

There is no special requirements on `name`. Usually it is selected to be a unique and descriptive string.

It is possible to reuse the same flow name for different methods.

### `inFlowOf(name)`

Returns a falsy value, if `name` flow is not in our call stack. Otherwise it returns a non-zero number, which indicates how many times it is encountered in our call stack.

### `getStack()`

Returns an array of flow names encountered to this point.

### `getCount()`

Returns a dictionary of flow counters, where a flow name serves as a key, and a counter (how many times this flow was encountered in our call stack) as a value.

## Examples

Class-level example:

{% codeblock flow class-level example lang:js %}
// our "class":
var Ackermann = dcl(null, {
  declaredName: "Ackermann",
  m0: function (n) {
    return n + 1;
  },
  n0: function (m) {
    return this.a(m - 1, 1);
  },
  a: function (m, n) {
    if (m == 0) {
      return this.m0(n);
    }
    if (n == 0) {
      return this.n0(m);
    }
    return this.a(m - 1, this.a(m, n - 1));
  }
});

// our advised version:
var AdvisedAckermann = dcl(Ackermann, {
  declaredName: "AdvisedAckermann",
  m0: dcl.advise(flow.advice("m0")),
  n0: dcl.advise(flow.advice("n0")),
  a:  dcl.advise(flow.advice("a")),
});

// our instrumented version:
var InstrumentedAckermann = dcl(
  [Ackermann, AdvisedAckermann],
  {
    m0: dcl.around(function (sup) {
      return function (n) {
        console.log("m0 - a() was called: " + (flow.inFlowOf("a") || 0));
        console.log("m0 - n0() was called: " + (flow.inFlowOf("n0") || 0));
        var stack = flow.getStack();
        var previous = stack[stack.length - 2] || "(none)";
        console.log("m0 - called directly from: " + previous);
        return sup.call(this, n);
      }
    })
  }
);

var x = new InstrumentedAckermann();
x.a(1, 1);
{% endcodeblock %}

Object-level example:

{% codeblock flow object-level example lang:js %}
// our "class":
var x = new Ackermann();

// advise with flow
advise(x, "m0", flow.advise("m0"));
advise(x, "n0", flow.advise("n0"));
advise(x, "a",  flow.advise("a"));

// our special advise:
advise.around(x, "m0", function (sup) {
  return function (n) {
    console.log("m0 - a() was called: " + (flow.inFlowOf("a") || 0));
    console.log("m0 - n0() was called: " + (flow.inFlowOf("n0") || 0));
    var stack = flow.getStack();
    var previous = stack[stack.length - 1] || "(none)";
    console.log("m0 - called directly from: " + previous);
    return sup.call(this, n);
  };
});

x.a(1, 1);
{% endcodeblock %}

In both case the output would be:

{% codeblock output lang:text %}
m0 - a() was called: 3
m0 - n0() was called: 1
m0 - called directly from: a
m0 - a() was called: 2
m0 - n0() was called: 0
m0 - called directly from: a
{% endcodeblock %}
