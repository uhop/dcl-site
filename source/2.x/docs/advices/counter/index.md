---
layout: page
title: "counter()"
date: 2017-06-08 13:54
comments: false
sharing: true
footer: true
---

*Version 2.x*

`counter()` returns an instance of an object, which can be used as an AOP advice to track how many times a method (or methods) was called, and how many times it produced an error (thrown an exception based on `Error`).

This advice is used mainly to profile and to debug methods.

It is defined in `dcl/advices/counter.js`.

## Description

The value of this module is a factory function that returns an object used to provide an AOP advice to profile/debug methods. This is an API of that object:

{% codeblock Counter lang:js %}
var Counter = new dcl(null, {
  declaredClass: "dcl/advices/counter/Counter",
  calls: 0,
  errors: 0,
  constructor: function () {...},
  reset: function () {...},
  advice: function () {...}
});
{% endcodeblock %}

### `calls`

`calls` is a numeric property that counts how many times the method was called.

### `errors`

`errors` is a numeric property that counts how many times the method returned an error (threw an exception based on `Error`).

### Constructor

The constructor initializes an internal state by setting `calls` and `errors` to 0.

### `reset()`

Sets `calls` and `errors` to 0.

### `advice()`

Returns an advice object that can be weaved with any given method. It can be used directly with [dcl.advise()](/2.x/docs/dcl_js/advise/) or [advise()](/2.x/docs/advise_js/advise/).

## Examples

We can use a counter to track calls for all instances at the same time:

{% codeblock counter() class-level example lang:js %}
// our object:
var A = dcl(null, {
  declaredClass: "A",
  showThis: function () {...},
  showThat: function () {...},
  hide:     function () {...}
});

// our counters
var countShows = counter();
var countHides = counter();

// instrumented version:
var InstrumentedA = dcl(A, {
  declaredClass: "InstrumentedA",
  showThis: dcl.advise(countShows.advice()),
  showThat: dcl.advise(countShows.advice()),
  hide:     dcl.advise(countHides.advice())
});

// as you can see we count showThis() and showThat() together,
// while hide() is counted separately

// our instrumented instances:
var x = InstrumentedA();
var y = InstrumentedA();

// working with x and y

// now we are ready for results:
console.log("Shows: " + countShows.calls +
  " (with " + countShows.errors + " errors)");
console.log("Hides: " + countHides.calls +
  " (with " + countHides.errors + " errors)");

// let's reset results:
countShows.reset();
countHides.reset();

// now we are ready to take another measurement
{% endcodeblock %}

Or we can work with them on per-instance basis:

{% codeblock counter() object-level example lang:js %}
// our instances:
var x = A();
var y = A();

// our counters
var countShows = counter();
var countHides = counter();

// we want to instrument only x instance:
advise(x, "showThis", countShows.advice());
advise(x, "showThat", countShows.advice());
advise(x, "hide",     countHides.advice());

// as you can see we count showThis() and showThat() together,
// while hide() is counted separately

// working with x and y, only x is tracked

// now we are ready for results:
console.log("Shows: " + countShows.calls +
  " (with " + countShows.errors + " errors)");
console.log("Hides: " + countHides.calls +
  " (with " + countHides.errors + " errors)");

// let's reset results:
countShows.reset();
countHides.reset();

// now we are ready to take another measurement
{% endcodeblock %}
