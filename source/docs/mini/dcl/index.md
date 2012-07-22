---
layout: page
title: "dcl()"
date: 2012-07-21 13:53
comments: false
sharing: true
footer: true
---

`dcl()` is a main function of the whole package. It is defined in [mini.js](/docs/mini) and can be extended by
[dcl.js](/docs/dcl). Both these modules return it as their value.

## Description

{% codeblock Signature lang:js %}
var dcl = require("dcl");
// or: var dcl = require("dcl/mini");
var Ctr = dcl(base, props);
{% endcodeblock %}

Description of all arguments and a return value:

* `base` is a base "class". It can be one of three:
  * `null` - no base "class" &rArr; base it directly on `Object`.
  * **constructor object** - a function created with `dcl` or a generic JavaScript constructor function. New "class" will be
    based on it using a single inheritance.
  * **array of constructors** - a C3 superclass linearization will be performed on this array, and the result will be used
    to create a new constructor using a single inheritance. This array should be non-empty.
* `props` is an object, whose properties are used to specify unique features of the "class" &mdash; methods, and
  class-level variables. Following properties have a special meaning for `dcl()`:
  * `constructor` - an optional function, which will be called when an object is created. A base constructor (if any) is
    always called before a derived constructor. There is no restrictions on what arguments can be used for
    a constructor. A return value of constructor (if any) is ignored.
  * `declaredClass` - an optional human-readable string, which is used to identify the created class in error messages
    or logs. See [debug.js](/docs/debug) for more details.
* `dcl()` returns a constructor created according to user' specifications.

`dcl()` is returned by [mini.js](/docs/mini) and [dcl.js](/docs/dcl) and used to host additional properties. Look at
 specific modules to learn what public properties are available.


## Examples

### `base` is `null`

In this case produced "classes" have no parent, or, to be more precise, are derived directly from `Object`.

{% codeblock No base lang:js %}
var Counter = dcl(null, {
	declaredClass: "Counter",
	constructor: function(initValue){
		this.acc = isNaN(initValue) ? 0 : initValue;
	},
	increment: function(){
		return ++this.acc;
	},
	decrement: function(){
		return --this.acc;
	},
	advance: function(delta){
		return this.acc += delta;
	}
});
var c = new Counter(5);
{% endcodeblock %}

### Single inheritance

This is a familiar scenario for most programmers: we build on an existing "class" producing a new "class".

{% codeblock Single inheritance I lang:js %}
var A = dcl(null, {
	constructor: function(){
		console.log("A is constructed");
	},
	hi: function(){
		console.log("Hi from A!");
	},
	lo: function(){
		console.log("Lo from A!");
	}
});
var a = new A();
// A is constructed
a.hi();
// Hi from A!
a.lo();
// Lo from A!

var B = dcl(A, {
	constructor: function(){
		console.log("B is constructed");
	},
	hi: function(){
		console.log("Hi from B!");
	}
});
var b = new B();
// A is constructed
// B is constructed
b.hi();
// Hi from B!
b.lo();
// Lo from A!

var C = dcl(null, {
	constructor: function(){
		console.log("C is constructed");
	},
	lo: function(){
		console.log("Lo from C!");
	}
});
var c = new C();
// A is constructed
// B is constructed
// C is constructed
c.hi();
// Hi from B!
c.lo();
// Lo from C!
{% endcodeblock %}

We can base our classes on native JavaScript constructors as well:

{% codeblock Single inheritance II lang:js %}
function A(){
	console.log("A is constructed natively");
}
A.prototype{
	hi: function(){
		console.log("Hi from native land!");
	},
	lo: function(){
		console.log("Lo from native land!");
	}
};
var a = new A();
// A is constructed natively
a.hi();
// Hi from native land!
a.lo();
// Lo from native land!

var B = dcl(A, {
	constructor: function(){
		console.log("B is constructed");
	},
	hi: function(){
		console.log("Hi from dcl()!");
	}
});
var b = new B();
// A is constructed natively
// B is constructed
b.hi();
// Hi from dcl()!
b.lo();
// Lo from native land!
{% endcodeblock %}

### Multiple inheritance with mixins

The dreaded [diamond](http://en.wikipedia.org/wiki/Diamond_problem) &mdash; the bane of multiple inheritance.
`dcl()` deals with it with ease:

{% codeblock Multiple inheritance: Diamond lang:js %}
var A = dcl(null,   {constructor: function(){ console.log("A"); }});
var B = dcl(A,      {constructor: function(){ console.log("B"); }});
var C = dcl(A,      {constructor: function(){ console.log("C"); }});
var D = dcl([B, C], {constructor: function(){ console.log("D"); }});
var d = new D();
// A
// B
// C
// D
{% endcodeblock %}

A triangle will be handled too:

{% codeblock Multiple inheritance: Triangle lang:js %}
var A = dcl(null,   {constructor: function(){ console.log("A"); }});
var B = dcl(A,      {constructor: function(){ console.log("B"); }});
var C = dcl([B, A], {constructor: function(){ console.log("C"); }});
var c = new C();
// A
// B
// C
{% endcodeblock %}

## Notes

1. Constructors are chained using "after" chaining, meaning that a derived constructor will be called only *after* its
base constructor.
2. Missing constructors are treated as empty constructors logically.
3. All constructors are called with the same set of arguments.
4. If a constructor returns a value, it will be ignored.
5. All unchained methods (the default), and other properties, override properties with the same name in base classes.
6. Always use `new` keyword when creating objects with a constructor produced by `dcl()`.
7. Methods in `props` will be decorated with a meta information, and possibly copied. Because of that it is not
recommended to reuse them for different classes. In general `props` should be an object literal. `dcl()` will assume
full control over it.

## FAQ

### What is the difference between `mini.js` and `dcl.js` modules and when should I use `mini.js`?

Both [mini.js](/docs/mini) and [dcl.js](/docs/dcl) return the same object. `mini.js` provides the core functionality
(mixin support, and super calls), while `dcl.js` adds chaining, and class-level AOP advices. By default, when you
request `dcl`, it loads `dcl.js`:

{% codeblock dcl.js lang:js %}
var dcl = require("dcl");
// code
{% endcodeblock %}

If you application has very tight bandwidth constraints, and doesn't use advanced features (e.g., small application
targeting mobile browsers), you may want to request `mini.js` explicitly (assuming
[AMD](https://github.com/amdjs/amdjs-api/wiki/AMD)):

{% codeblock mini.js lang:js %}
// in browser
define(["dcl/mini"], function(dcl){
	// code
});
{% endcodeblock %}

### How does `dcl()` linearize superclasses?

`dcl()` uses the [C3 superclass linearization](http://en.wikipedia.org/wiki/C3_linearization) algorithm. This is the
same proven algorithm that powers Python (since 2.3), Perl 6, Parrot, and Dylan. The best discussion of this algorithm
I know of is in this paper: [The Python 2.3 Method Resolution Order](http://www.python.org/download/releases/2.3/mro/).
Effectively this algorithm is a topological sorting of an inheritance graph with complexity O(n).

### Why do I need the linearization? I don't do no "diamonds" in my code.

Unfortunately dependency loops, and reversed dependencies can happen accidentally, especially in big projects, which are
targeted by this OOP package. It is very difficult to keep track of all mixins, and their dependencies, especially when
they are written by other programmers, or even 3rd-party shops. `dcl()` keeps track of all these matters for you
linearizing bases, eliminating duplicates, and checking the overall consistency of your "classes".

Many JS OOP packages skip the correct linearization step hoping that everything will be right as is. Unfortunately it
can be a source of extremely hard-to-find bugs. Besides mixins use inheritance routinely to indicate their relative
dependencies so duplicates will occure natirally.

### I write only small programs. I don't need no linearization, right?

If you write only small programs, chances are you don't need OOP. See discussion of the OOP applicability area in
[OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/), specifically "fail #2".

### Can I use hand-made constructors as bases or mixins with `dcl()`?

Yes, you can &mdash; the code example is above. Obviously your classes cannot use advanced techniques like super calls,
or class-level advices, but other than that they can be used without restrictions.

### Is it possible to chain methods other constructor?

Yes. See [chainBefore()](/docs/dcl/chainbefore) and [chainAfter()](/docs/dcl/chainafter) directives provided by
[dcl.js](/docs/dcl).

### Is it possible to use advices with constructors?

Yes. The full set of advices can be used with constructors.

### Is it possible to "break" a chain of constructors or other chained methods?

While it is not advised due to possible violation of object invariants, and potential maintenance problems, you can do
it with super calls &mdash; just define a super call and doesn't call a super.

See [superCall()](/docs/mini/supercall) for more details.

See discussion of object invariants in [OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/) and in
[OOP in JS revisited](http://lazutkin.com/blog/2012/jul/17/oop-n-js-slides/).

### Can I use `[]` instead of `null` as my base?

No. `null` is a constant, which is shared, while `[]` is a newly-created object. The latter comes with a penalty (it
has to be created, and it will add a load to the garbage collector afterwards. `null` is cheaper, and clearly
demonstrates programmer's intent.

### Can I use `[base]` instead of `base` as my base?

Yes, but why? The former will create an additional array object, which will be discarded right after the `dcl()` call
increasing the load on the garbage collector. The latter is clearly cheaper, and more intentional.
