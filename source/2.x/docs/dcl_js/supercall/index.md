---
layout: page
title: "dcl.superCall()"
date: 2017-06-04 13:53
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.superCall()` is a light-weight way to call a method with the same name from the base "class", if any. Essentially
it is a way to call a method that was overridden by the current method. It is used as a method
[decorator](../general/decorator).

It is defined as a property on `dcl`.

## Description

When you need to do a supercall, you decorate/wrap a method with `dcl.superCall()` using a double function pattern:

{% codeblock Double function pattern lang:js %}
	method: dcl.superCall(function (sup) {
		return function (x) {
			...
		};
	})
{% endcodeblock %}

The outer function always have one argument: `sup` (any name is fine). It is used to inject a method of super class
in the inner function, which does the useful job. The outer function always returns the inner function.

The inner function takes as many arguments as required and returns the actual value. It is the workhorse of the tandem.
In doing its work it can optionally call its super method.

It is worth noting that `sup` is an unadorned super method. Most probably you want to call it in context of a current
object. Do not forget to use standard `apply()` or `call()` methods to supply an object, and/or arguments:

{% codeblock Calling a super lang:js %}
	calcPrice: dcl.superCall(function (sup) {
		return function (x) {
		    // asking for a real price in three different yet equivalent ways:
			var realPrice1 = sup.apply(this, arguments);
			var realPrice2 = sup.apply(this, [x]);
			var realPrice3 = sup.call(this, x);
			// now let's return it tripled
			return realPrice1 + realPrice2 + realPrice3;
		};
	})
{% endcodeblock %}

It is possible that there is no super method to call (e.g., this "class" is the first one in line). In this case the
injected `sup` will be falsy. It is a good idea to check `sup` for presence.

{% codeblock Handling possibly missing super lang:js %}
	log: dcl.superCall(function (sup) {
		return function (msg) {
		    var newMsg = "LOG: " + msg;
		    if (sup) {
		        sup.call(this, newMsg);
		    } else {
		        console.log(newMsg);
		    }
		};
	})
{% endcodeblock %}


The reason to use the double function pattern is described in [Supercalls in JS](../general/supercalls).

Transitioning from a regular method to a method, which can execute a supercall is very simple:

{% codeblock Before applying a decorator lang:js %}
	method: function X (a, b, c) {
		return a * b * c;
	}
{% endcodeblock %}

In the example above we transition a method called `method`, which is implemented by a function called `X`.
Let's transition it to a supercalling method:

{% codeblock After applying a decorator lang:js %}
	method: dcl.superCall(function (sup) {
		return function X (a, b, c) {
			return a * b * c;
		};
	})
{% endcodeblock %}

As you can see our `X` function is completely preserved &mdash; all arguments are the same, its code, and its return
value is completely intact. We just added a decorator and a trivial wrapper function that returns `X`. Now our method
can take advantage of a supercall, which is injected using `sup` argument of the wrapper.

## Example

More complete example:

{% codeblock Example lang:js %}
var dcl = require("dcl");

var A = dcl(null, {
	method: function (x, y) {
		// we will call this method implicitly from B
		console.log("A:", x, y);
		return x + y;
	}
});

var B = dcl(A, {
	method: dcl.superCall(function (sup) {
		return function (x, y) {
			var r = 0;
			console.log("B:", x, y);
			if (sup) {
				r = sup.call(this, x, y);
				// or: r = sup.apply(this, arguments);
				// or: r = sup.apply(this, [x, y]);
			} else {
				console.log("B: no super");
			}
			return r + 1;
		};
	})
});
{% endcodeblock %}

In the example above `B` can always expect that `A` comes before it, and `method()` in `B` always have a super method,
meaning that checking for `sup` to be truthy/falsy was unnecessary. But even in trivial cases like in the example above
possible modifications/refactoring may subtly change your assumptions making the check necessary.

## Notes

1. If a method is present in an `Object`, it will be the last in line of potential super calls.
2. It is not necessary to call a super method. This decision can be made dynamically.
3. The funky double function pattern allows for static chaining of super calls. In this context "static" means "once at
constructor definition".
   1. It makes super calls as cheap as possible. No extra expenses per call.
   2. It makes debugging simple: going inside a super call brings a programmer directly to the next method without any
      stubs, thunks, or wrapper functions.
   3. Even if a programmer failed to check if `sup` is truthy and called it anyway, JavaScript will generate
      an exception pointing directly to the site of failure without any intermediaries.
   4. Both functions should be unique and created dynamically exactly like in examples.
4. If a super method throws an exception, it is a programmer's responsibility to catch it, to ignore it, or to pass it
   through.

## FAQ

### Is it possible to call built-in functions like that?

Yes.

{% codeblock Calling toString() lang:js %}
var A = dcl(null, {
	toString: dcl.superCall(function (sup) {
		return function () {
			// no need to check if sup exists here
			return "prefix-" + sup.call(this) + "-postfix";
		};
	})
});
{% endcodeblock %}

### Is it possible to use a super call in a chained method?

Yes. In this case, if a super is not called, a chain is interrupted. It is one of the methods to interrupt chained
constructors. **Think twice before interrupting construction chains &mdash; usually it is a bad idea.**

{% codeblock Interrupting constructors lang:js %}
var A = dcl(null, {
	constructor: function () {
		console.log("A");
	}
});

var B = dcl(A, {
	constructor: function () {
		console.log("B");
	}
});

var C = dcl(A, {
	constructor: dcl.superCall(function (sup) {
		// we don't use sup at all
		return function () {
			console.log("C");
		};
	})
});

var b = new B();	// prints lines: A, B
var c = new C();	// prints lines: C
{% endcodeblock %}

The same can be done with any chained method. See [dcl.chainBefore()](chainbefore) and
[dcl.chainAfter()](chainafter) for more details.
