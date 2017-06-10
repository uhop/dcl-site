---
layout: page
title: "memoize"
date: 2017-06-08 13:55
comments: false
sharing: true
footer: true
---

*Version 2.x*

`memoize` is a classic AOP helper, which caches a result value of a method helping to speed up calculations.

It is defined in `dcl/advices/memoize.js`.

## Description

The module provides two public functions described below. Those functions can defined a property on an instance called `__memoizerCache`.

This is an API of the module:

{% codeblock memoize lang:js %}
var memoize = {
  advice: function (name, keyMaker) {...},
  guard:  function (name) {...}
};
{% endcodeblock %}

### `advice(name, keyMaker)`

This method creates an advice object that can bypass the original method, if its result for a given combination of parameters is already cached.

`name` is a unique name identifying an object-level cache for the method. Usually it is a method name. If you reuse the same name for different methods of the same object, make sure that those methods are logically the same and return the same values.

`keyMaker` is an optional parameter. It is a function, which takes two arguments:

1. `instance`, which is an object we operate on.
2. `args`, which is an `arguments` object, which was used to call our method.

`keyMaker` should return an object (usually a string) that uniquely identifies the combination of arguments in cache. If `keyMaker` is not present, the first arguments' string representation is used as a cache key.

The return value of `advice()` is an advice object, which can be used directly with [dcl.advise()](/2.x/docs/dcl_js/advise/) or [advise()](/2.x/docs/advise_js/advise/).

### `guard(name)`

This method creates an advice object that clears the named cache.

`name` parameter indicates, which cache we want to clear on an object. This name is the same as used by `advice(name, keyMaker)`.

It returns an advice object, which can be used directly with [dcl.advise()](/2.x/docs/dcl_js/advise/) or [advise()](/2.x/docs/advise_js/advise/).

## Examples

Class-level example:

{% codeblock memoize class-level example lang:js %}
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

// let's speed it up!
var InstrumentedStack = dcl(Stack, {
  declaredClass: "InstrumentedStack",
  // sum() should be cached
  sum: dcl.advise(memoize.advice("sum")),
  // but it will change when more numbers
  // pushed and popped => reset cache
  push: dcl.advise(memoize.guard("sum")),
  pop:  dcl.advise(memoize.guard("sum"))
});

var x = new InstrumentedStack();
{% endcodeblock %}

Object-level example:

{% codeblock memoize object-level example lang:js %}
// our instance
var x = new Stack();

// let's speed it up!
// sum() should be cached
advise(x, "sum", memoize.advice("sum"));
// but it will change when more numbers
// pushed and popped => reset cache
advise(x, "push", memoize.guard("sum"));
advise(x, "pop",  memoize.guard("sum"));
{% endcodeblock %}

More complex example with Ackermann function and `keyMaker`:

{% codeblock memoize Ackermann example lang:js %}
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

var InstrumentedAckermann = dcl(Ackermann, {
  declaredName: "InstrumentedAckermann",
  m0: dcl.advise(memoize.advice("m0")),
  n0: dcl.advise(memoize.advice("n0")),
  a:  dcl.advise(memoize.advice("a", function (self, args) {
    return args[0] + "-" + args[1];
  }))
});

var x = new InstrumentedAckermann();
{% endcodeblock %}
