---
layout: page
title: "dcl.delegate()"
date: 2012-07-21 13:52
comments: false
sharing: true
footer: true
---

This is a utility function that facilitates a delegation from one object to another bypassing a constructor.
It is used inside `dcl` and exposed because it is frequently required by user's code.

## Description

It creates an empty object with a desired prototypal inheritance. All missing properties will be delegated.

The best way to describe `dcl.delegate()` is to give its definition:

{% codeblock dcl.delegate() lang:js %}
function F(){} // private empty constructor function

dcl.delegate = function(o){
  // assigning the object as a prototype to an empty function
  F.prototype = o;
  // creating new empty object with a desired prototype
  var t = new F;
  // cleaning up our prototype to prevent a memory leak
  F.prototype = null;
  // return our object
  return t;
};
{% endcodeblock %}

## Examples

{% codeblock Delegation lang:js %}
var x = dcl.delegate({a: 1, b: 2});

console.log(x.a); // 1
console.log(x.b); // 2
console.log(x.c); // undefined

x.a = 42;
console.log(x.a); // 42

delete x.a;
console.log(x.a); // 1

x.c = "hello!";
console.log(x.c); // hello!

delete x.c;
console.log(x.c); // undefined
{% endcodeblock %}

## Notes

`dcl.delegate()` is a first half of
[Object.create()](https://developer.mozilla.org/en-US/docs/JavaScript/Reference/Global_Objects/Object/create),
which is defined in ECMAScript 5, and supported by all modern browsers. Unfortunately IE supports it starting from IE9,
so `dcl` carries this manual implementation to support previous IE browsers.