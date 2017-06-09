---
layout: page
title: "time()"
date: 2017-06-08 13:55
comments: false
sharing: true
footer: true
---

*Version 2.x*

`time(name)` creates a named timer using a standard `console` interface: `console.time(name)` and `console.timeEnd(name)`.

It is defined in `dcl/advices/time.js`.

## Description

The result value of `time` module is a function, which takes a string parameter `name`, and returns an advice object, which can be used directly with [dcl.advise()](../dcl_js/advise) or [advise()](../advise_js/advise).

The advice prints on console when a method was invoked, and when it finished. Recursive calls are allowed, but only first invocation is printed.

If `name` is not specified, a unique name is generated.

## Examples

{% codeblock time() example lang:js %}
var Stack = dcl(null, {
  declaredClass: "Stack",
  constructor: function () {
    this.stack = [];
  },
  push: function (n) {
    return this.stack.push(n);
  },
  pop: function () {
    return this.stack.pop();
  },
  sum: function (init) {
    // expensive, yet frequently called method
    // it has a linear complexity on stack size
    var acc = init;
    for (var i = 0; i < this.stack.length; ++i) {
      acc += this.stack[i];
    }
    return acc;
  }
});

var x = new Stack();

advise(x, "sum", time("sum"));
x.push(1);
x.push(2);
x.push(3);
var n = x.sum(0);
{% endcodeblock %}

The example above will print something like that:

{% codeblock output lang:text %}
sum: 0.089ms
{% endcodeblock %}
