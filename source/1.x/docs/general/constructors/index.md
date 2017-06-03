---
layout: page
title: "Constructors"
date: 2012-07-29 01:16
comments: false
sharing: true
footer: true
---

*Version 1.x*

When you design your mixins and classes for a project, one question arises quite
frequently: how to deal with constructors and their parameters?

Obviously it is not a problem for mixins without constructors, or for mixins,
which constructors do not require parameters. But what if they do?

## Slot-based assignment

One possible solution to separate parameters for different components is to assign
different slots for different mixins. For example, we may reserve an argument #1
for a class itself, #2 for `Mixin1`, and #3 for `Mixin2`:

```js
var Base = dcl(null, {
  declaredClass: "Base",
  constructor: function(param){
    // use param to initialize the instance
  }
});

var Mixin1 = dcl(null, {
  declaredClass: "Mixin1",
  constructor: function(){
    var param = arguments[1];
    // use param to initialize the instance
  }
});

var Mixin2 = dcl(null, {
  declaredClass: "Mixin2",
  constructor: function(){
    var param = arguments[2];
    // use param to initialize the instance
  }
});

var Example1 = dcl(
  [Base, Mixin1, Mixin2],
  {}
);

var x = new Example1(1, true, "seven");
```

While this techniques works, **it doesn't scale well** for real-life projects with
dozens mixins, and it is extremely error prone (both assigning slots, and specifying
parameter values). It can be used only on small scale.

But what if our constructor needs more than one value, or a variable number of values?

### Put it in a bag

One solution is to put all required parameters in a bag switching from positional parameters to named parameters:

```js
var Mixin3 = dcl(null, {
  declaredClass: "Mixin3",
  constructor: function(){
    var args = arguments[3];
    this.name = args.name || "Anonymous";
    this.age  = args.age  || null;
    if("secret" in args){
      this.secret = args.secret;
    }else{
      this.secret = "unspecified";
    }
  }
});

var Example2 = dcl(
  [Base, Mixin1, Mixin2, Mixin3],
  {}
);

var x = new Example2(1, true, "seven", {
  name: "Bob",
  age:  99
});
```

Another potential problem is that sometimes we don't know what slot is available,
or don't like the default placement.

## Parameterized mixins

Given a dynamic nature of `dcl` it is super-easy to parameterized any mixin:

```js
var mixinN = function(n){
  return dcl(null, {
    declaredClass: "MixinN",
    constructor: function(){
      var param = arguments[n];
      // use param to initialize the instance
    }
  });
};

var Example3 = dcl(
  [Base, Mixin1, Mixin2, Mixin3, mixinN(4)],
  {}
);
```

## Global bag

While we learned valuable techniques from above sections, the slot allocation has
a lot of problems making it unsuitable as a generic solution:

* It doesn't scale up well, if we insist that every mixin had its own parameter slot.
* It is error-prone to design, and to specify constructor parameters.
* What if different mixins require the same or similar parameter?
  Should we duplicate them?
* Mixing three mixins that require just 5th, 50th, and 100th slots are ridiculous.

The simplest solution is to mandate that all our bases and mixins use the only one
parameter, which is a key-value dictionary (a bag). Each participant takes named
values it knows about ignoring others. Essentially it is a recreation of `kwargs`
parameters of Python.

```js
var Person = dcl(null, {
  declaredClass: "Person",
  constructor: function(args){
    this.firstName = args.firstName;
    this.lastName  = args.lastName
  }
});

var FullName = dcl(null, {
  declaredClass: "FullName",
  constructor: function(args){
    this.fullName = args.firstName + " " +
      args.lastName;
  }
});

var Age = dcl(null, {
  declaredClass: "Age",
  constructor: function(args){
    this.age = args.age || null;
  }
});

var HRRecord = dcl(
  [Person, FullName, Age],
  {
    declaredClass: "HRRecord"
  }
);
```

This way when designing mixins, we can carefully select names for our named parameters
and ensure that our mixins are consistent with naming and using data.

The only problem is a possible data duplication. For example, several mixins need to know
`name`. It appears that the best way to do that is to save the parameter, which may lead
to several mixins storing the same information again and again. Is there a solution
for that?

### Mixer

One possible solution is to mix in all parameters from a bag on instance, and take all
of them directly from there:

```js
var Mixer = dcl(null, {
  constructor: function(x){
    dcl.mix(this, x);
  }
});
```

This way we can rewrite our HR classes like that:

```js
var Person = dcl(Mixer, {
  declaredClass: "Person"
});

var FullName = dcl(Mixer, {
  declaredClass: "FullName",
  constructor: function(){
    this.fullName = this.firstName + " " +
      this.lastName;
  }
});

var Age = dcl(Mixer, {
  declaredClass: "Age",
  constructor: function(){
    if(!this.age){
      this.age = null;
    }
  }
});

var HRRecord = dcl(
  [Person, FullName, Age],
  {
    declaredClass: "HRRecord"
  }
);
```

We based all our classes on `Mixer` to make sure that it is included before them.

As you can see nobody accesses arguments directly, and now `Person` has an empty
constructor, because all it did before it copied arguments to instance. Now it is
done automatically. And we don't need to worry about duplicating information in
different mixins -- they all use the same source (an instance).

What if our bag contains some extra properties, which are unused, or clash with
existing instance properties, or even methods? It can be a good or bad side-effect.

The good part is that it allows us to customize individual objects:

```js
var x = new HRRecord({
  firstName: "Robert",
  lastName:  "Smith",
  salut: function(){
    return "Hi, " + this.firstName + "!";
  }
});
x.salut();
```

We can override existing behavior and properties, or add new properties. Obviously
for this to work, a parameter bag should be sanitized. It cannot contain random
properties. Usually it is not a problem.

One obvious drawback is copying properties that should not be copied, e.g.,
they are used as a source data for some other properties, but never used directly.
And keeping them around just in case can be troublesome, especially if they take up
a lot of space or consume other precious resources. This problem can be easily solved
with [multi-stage construction](../general/multi-stage-construction).

`Mixer` above is a very helpful class, which is provided with `dcl`.
Read all about it in the documentation on [Mixer](../bases/mixer).

### Replacer

`Replacer` is a variation on [Mixer](../bases/mixer), which replaces properties
on an instance ignoring new properties. This is a form of automatic sanitation of
"dirty" parameter bags. With `Replacer` we statically define what properties are
available on an instance and will be copied automatically. Let's rewrite our HR
mixins again:

```js
var Person = dcl(replacer, {
  declaredClass: "Person",
  // our parameters:
  firstName: "",
  lastName:  ""
});

var FullName = dcl(Mixer, {
  declaredClass: "FullName",
  constructor: function(){
    this.fullName = this.firstName + " " +
      this.lastName;
  }
});

var Age = dcl(Mixer, {
  declaredClass: "Age",
  // our parameters:
  age: null,
  // our constructor
  constructor: function(){
    if(!this.age){
      this.age = null;
    }
  }
});

var HRRecord = dcl(
  [Person, FullName, Age],
  {
    declaredClass: "HRRecord"
  }
);
```

This time all stray parameters will be ignored, yet we still can override existing
properties and methods:

```js
var x = new HRRecord({
  firstName: "Robert",
  lastName:  "Smith",
  salut: function(){
    return "Hi, " + this.firstName + "!";
  }
});
typeof x.salut; // undefined
```

`Replacer` is provided with `dcl`. Read all about it in the documentation on
[Replacer](../bases/replacer).

### More on mixers

This concept can be extended to suit particular needs. One notable extension is to
check types of instance properties, and enforce that copied properties are of
the same type, or coerce it to that type. For example, `firstName` property above is
defined as a string, so we san check that `firsName` parameter is a string too.

And we can implement some additional restrictions too, e.g., skip all function
parameters, or skip all parameters that start with `_`.

## Summary

Techniques described above are simple yet powerful. They go beyond constructors,
and can be used for methods as well. Always take practical scalability
into account while designing mixins and base classes for your project.
