---
layout: page
title: "dcl()"
date: 2017-06-04 13:53
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl()` is the "class" composition helper, which simplifies creating constructors for new classes of objects:

* It reduces a boilerplate to set up a single inheritance.
* In case of mixin-based multiple inheritance it correctly linearizes all dependencies.
* While composing constructors, it can process advanced features:
  * Super calls, when you need to call a method of a super class (a base).
  * Define property descriptors inline (getters/setters, non-enumerable methods, and so on).
  * AOP advices.
  * Automatic method chaining.

Of course, an experienced programmer can do all this stuff manually, but `dcl()` offers a less error-prone and more
compact way to achieve what you need. But, just in case, it will play nice with hand-made constructors, so your
constructors can inherit from them, or mix them in as mixins.

`dcl()` is a main function of the whole package.

## Description

{% codeblock Signature lang:js %}
var dcl = require("dcl");

// Full signature:
var Ctr = dcl(base, props, options);

// Supported signatures:
dcl(base);           // no own properties
dcl(base, props);    // use default options
dcl(props);          // based on Object
dcl(props, options); // based on Object with default options
{% endcodeblock %}

Arguments and the return value:

* `base` - the base "class". It can be one of three:
  * `null` - no base "class" &rArr; base it directly on `Object`.
  * **constructor function** - function created with `dcl` or a generic JavaScript constructor function. New "class" will be based on it using a single inheritance.
  * **array of constructors** - [C3 superclass linearization](http://en.wikipedia.org/wiki/C3_linearization) will be performed on this array, and the result will be used to create a new constructor using a single inheritance. This array should be non-empty.
* `props` - the object, whose properties are used to specify unique features of the "class" &mdash; methods, and
  class-level variables.
  `props` can be an instance of [dcl.Prop](/2.x/docs/dcl_js/prop/). In this case, it specifies property descriptors directly, like for [Object.defineProperties()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperties) or [Object.create()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/create).
  Following properties have a special meaning for `dcl()`:
  * `constructor` - the optional function, which will be called when an object is created. A base constructor (if any) is
    always called before a derived constructor. There is no restrictions on what arguments can be used for
    a constructor. A return value of constructor (if any) is ignored.
  * `declaredClass` - the optional human-readable string, which is used to identify the created class in error messages
    or logs. See [debug.js][] for more details.
* `options` - the optional object, which specifies defaults for a descriptor of  [Object.defineProperty()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty).
  * Following property names are recognized: `enumerable`, `configurable`, `writable`, `detectProps`.
  * If `detectProps` is `true`:
    * All regular properties are checked to be an object.
      * If that object has only a valid subset of following properties: `get`, `set`, `value`, `enumerable`, `configurable`, `writable` &mdash; it is considered to be a property descriptor, which has the same effect as using `dcl.prop()` to wrap it.
    * More info on property descriptors can be found in [Object.defineProperty()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty).
  * If `enumerable`, `configurable`, or `writable` are Boolean values, they are added verbatim to all descriptors, which do not define those properties explicitly. It applies to property descriptors generated from regular properties by `dcl()`.
  * `enumerable`, `configurable`, or `writable` can be a procedure with two arguments:
    * `descriptor` is a property descriptor object, which can be inspected and augmented/corrected, if needed.
    * `name` is a property name as a string.
* `dcl()` returns the constructor created according to user' specifications.

`dcl()` hosts additional properties. Look at specific modules to learn what public properties are available.

## Examples

### No base

In this case produced "classes" are derived directly from `Object`.

{% codeblock No base lang:js %}
var Counter = dcl({
  declaredClass: "Counter",
  constructor: function (initValue) {
    this.acc = isNaN(initValue) ? 0 : initValue;
  },
  increment: function () {
    return ++this.acc;
  }
});
var c = new Counter(5);
{% endcodeblock %}

It will be the same as this:

{% codeblock No base alternative lang:js %}
var Counter = dcl(null, {
  declaredClass: "Counter",
  constructor: function (initValue) {
    this.acc = isNaN(initValue) ? 0 : initValue;
  },
  increment: function () {
    return ++this.acc;
  }
});
var c = new Counter(5);
{% endcodeblock %}

### Single inheritance

This is a familiar scenario for most programmers: we build on an existing "class" producing a new "class".

{% codeblock Single inheritance I lang:js %}
var A = dcl({
  constructor: function () {
    console.log("A is constructed");
  },
  hi: function () {
    console.log("Hi from A!");
  },
  lo: function () {
    console.log("Lo from A!");
  }
});
var a = new A();  // A is constructed
a.hi();           // Hi from A!
a.lo();           // Lo from A!

var B = dcl(A, {
  constructor: function () {
    console.log("B is constructed");
  },
  hi: function () {
    console.log("Hi from B!");
  }
});
var b = new B();  // A is constructed
                  // B is constructed
b.hi();           // Hi from B!
b.lo();           // Lo from A!

console.log(b instanceof A);  // true
console.log(b instanceof B);  // true

var C = dcl(B, {
  constructor: function () {
    console.log("C is constructed");
  },
  lo: function () {
    console.log("Lo from C!");
  }
});
var c = new C();  // A is constructed
                  // B is constructed
                  // C is constructed
c.hi();           // Hi from B!
c.lo();           // Lo from C!

console.log(c instanceof A);  // true
console.log(c instanceof B);  // true
console.log(c instanceof C);  // true
{% endcodeblock %}

We can base our classes on normal JavaScript constructors as well:

{% codeblock Single inheritance II lang:js %}
function A () {
  console.log("A is constructed manually");
}
A.prototype = {
  hi: function () {
    console.log("Hi from manual land!");
  },
  lo: function () {
    console.log("Lo from manual land!");
  }
};
var a = new A();  // A is constructed manually
a.hi();           // Hi from manual land!
a.lo();           // Lo from manual land!

var B = dcl(A, {
  constructor: function () {
    console.log("B is constructed");
  },
  hi: function () {
    console.log("Hi from dcl()!");
  }
});
var b = new B();  // A is constructed manually
                  // B is constructed
b.hi();           // Hi from dcl()!
b.lo();           // Lo from manual land!

console.log(b instanceof A);  // true
console.log(b instanceof B);  // true
{% endcodeblock %}

### Multiple inheritance with mixins

The dreaded [diamond](http://en.wikipedia.org/wiki/Diamond_problem) &mdash; the bane of multiple inheritance.
`dcl()` deals with it with ease:

{% codeblock Multiple inheritance: Diamond lang:js %}
var A = dcl(null,   {constructor: function(){ console.log("A"); }});
var B = dcl(A,      {constructor: function(){ console.log("B"); }});
var C = dcl(A,      {constructor: function(){ console.log("C"); }});
var D = dcl([B, C], {constructor: function(){ console.log("D"); }});
var d = new D();  // prints lines: A, B, C, D
{% endcodeblock %}

A triangle will be handled too:

{% codeblock Multiple inheritance: Triangle lang:js %}
var A = dcl(null,   {constructor: function(){ console.log("A"); }});
var B = dcl(A,      {constructor: function(){ console.log("B"); }});
var C = dcl([B, A], {constructor: function(){ console.log("C"); }});
var c = new C();  // prints lines: A, B, C
{% endcodeblock %}

Generally a "class", which inherits from an array, tries to use the first item as its base. In some cases it is not
possible due constraints on relative position of all bases. If that is the case, `Object` is used.

{% codeblock Multiple inheritance base lang:js %}
var A = dcl({declaredClass: "A"});
var B = dcl({declaredClass: "B"});
var C = dcl({declaredClass: "C"});

var D = dcl([A, B], {declaredClass: "D"});
var E = dcl([C, B], {declaredClass: "E"});

var F = dcl([D, E], {declaredClass: "F"});

require("dcl/debug"); // augments dcl

// let's inspect D:
dcl.log(D);
// *** class D depends on 2 classes: A, B
// *** class D has 1 weaver: constructor: after

// let's inspect F:
dcl.log(F);
// *** class F depends on 5 classes: A, C, B, D, E
// *** class F has 1 weaver: constructor: after
{% endcodeblock %}

If `F` can be based on `D`, our right-most list of dependencies should look like this: `D, B, A`, which is not the case.
`dcl()` cannot preserve this list because `C` should go before `B` as defined in `E`. It forces `dcl()` to base `F`
directly on `Object`.

For available debugging facilities take a look at [log()](/2.x/docs/debug_js/log/) method defined by [debug.js][].

If you want to test, whether or not an object is inherited directly (in JavaScript sense) or indirectly (e.g., as a mixin), consider using [isInstanceOf()](/2.x/docs/dcl_js/isinstanceof/).

### Make all properties read-only

{% codeblock All properties are read-only lang:js %}
var A = dcl({
    life: 42,
    answer: function () { return this.life; }
  }, {
    writable:     false
  });
{% endcodeblock %}

### Make specific property read-only

{% codeblock Specific property is read-only lang:js %}
var A = dcl({
    life: 42,
    answer: function () { return this.life; }
  }, {
    writable: function (descriptor, name) {
      if (name === 'life') {
        descriptor.writable = false;
      }
    }
  });
{% endcodeblock %}

### Define a property using a descriptor

For that, we will need [dcl.prop()](/2.x/docs/dcl_js/prop/).

{% codeblock Define a property lang:js %}
var A = dcl({
    x: dcl.prop({
        get: function ()  { return this.y || 0; },
        set: function (x) { return this.y = 2 * x; }
      })
  });

var a = new A();
console.log(a.x); // 0
a.x = 3;
console.log(a.x); // 6
{% endcodeblock %}

### Detect a property descriptor automatically

This style is useful, when mixing seamlessly regular (pre-ES5) properties with fancy property descriptions.
No `dcl.prop()` is required.

{% codeblock Use a property descriptor lang:js %}
var A = dcl({
    x: {
        get: function ()  { return this.y || 0; },
        set: function (x) { return this.y = 2 * x; },
        enumerable: false
      }
  }, {detectProps: true});

var a = new A();
console.log(a.x); // 0
a.x = 3;
console.log(a.x); // 6
{% endcodeblock %}

### Define a "class" using descriptors

All properties can be described as an object that contains property descriptors.

{% codeblock Use property descriptors lang:js %}
var A = dcl(dcl.prop({
    life: {value: 42},
    answer: {
      value: function () { return this.life; },
      enumerable: false
    }
  }));
{% endcodeblock %}

## Notes

1. Constructors are chained using "after" chaining, meaning that a derived constructor will be called only *after* its
base constructor.
2. Missing constructors are treated as empty constructors.
3. All constructors are called with the same set of arguments.
4. If a constructor returns a value, it will be ignored.
5. All unchained methods (the default), and other properties, override properties with the same name in base classes.
6. Always use `new` keyword when creating objects with a constructor produced by `dcl()`.
7. `dcl()` reuses property descriptors augmenting them, if needed.

## FAQ

### How can I detect, if my class inherits directly or indirectly from `A`?

You can always use [isInstanceOf()](/2.x/docs/dcl_js/isinstanceof/):

{% codeblock isInstanceOf() lang:js %}
var A = dcl({declaredClass: "A"});
var B = dcl({declaredClass: "B"});
var C = dcl({declaredClass: "C"});

var D = dcl([A, B], {declaredClass: "D"});
var E = dcl([C, B], {declaredClass: "E"});
var F = dcl([D, E], {declaredClass: "F"});

var d = new D();
console.log(d instanceof A);  // true

var e = new E();
console.log(e instanceof C);  // true

var f = new F();
console.log(f instanceof A);  // false
console.log(f instanceof C);  // false

console.log(dcl.isInstanceOf(f, A));  // true
console.log(dcl.isInstanceOf(f, C));  // true
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
dependencies so duplicates will occur naturally.

### I write only small programs. I don't need no linearization, right?

If you write only small programs, chances are you don't need OOP. See discussion of the OOP applicability area in
[OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/), specifically "fail #2".

### Can I use hand-made constructors as bases or mixins with `dcl()`?

Yes, you can. It was demonstrated in the code example above. Obviously your hand-made classes cannot use `dcl()`-based
facilities like super calls, or class-level advices, but other than that they can be used without restrictions.

### Is it possible to chain methods other than constructor?

Yes. See [chainBefore()](/2.x/docs/dcl_js/chainbefore/) and [chainAfter()](/2.x/docs/dcl_js/chainafter/) directives.

### Is it possible to use advices with constructors?

Yes. The full set of advices can be used with constructors.

### Is it possible to "break" a chain of constructors or other chained methods?

While it is not advised due to possible violation of object invariants, and potential maintenance problems, you can do
it with super calls &mdash; just define a super call and doesn't call a super.

See [superCall()](/2.x/docs/dcl_js/supercall/) for more details.

See discussion of object invariants in [OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/) and in
[OOP in JS revisited](http://lazutkin.com/blog/2012/jul/17/oop-n-js-slides/).

### Can I use `[]` instead of `null` as my base?

No, it wouldn't work.

In any case `null` is a constant, which is shared, while `[]` is a newly-created object. The latter comes with
a penalty (it has to be created, and it will add a load to the garbage collector afterwards. `null` is cheaper, and
clearly demonstrates programmer's intent.

If you do not calculate bases, it is easier to skip them completely, rather than use `null`.

### Can I use `[base]` instead of `base` as my base?

Yes, but why? The former will create an additional array object, which will be discarded right after the `dcl()` call
increasing the load on the garbage collector. The latter is clearly cheaper, and more intentional.

[debug.js]: /2.x/docs/debug_js/ debug.js
