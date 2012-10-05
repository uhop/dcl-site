---
layout: page
title: "Supercalls"
date: 2012-07-29 01:15
comments: false
sharing: true
footer: true
---

Supercalls (calling a super method, which was inherited and overridden) are an essential part of any inheritance scheme.
This is a facility that allows us to augment behavior of existing objects, paving a way to decompose large monolithic
objects into a collection of small incremental "classes". If used correctly, such "classes" can provide a completely
orthogonal set of building blocks, which will help us to keep an overall complexity down.

While JavaScript provides means to delegate methods of one object to another, there is no native provisions for
supercalls. It means that it should be provided by a helper.

## Available solutions

Let's take a look at different styles of possible supercalls in JavaScript.

### Direct call

This is as native as it can be:

{% codeblock Direct call lang:js %}
// our basic constructor and a method
var A = function(...){...};
A.prototype.method = function(...){...};

// our derived class
var B = function(...){
  // let's construct our parent first
  A.apply(this, arguments);
  // the above line already calls a super method
  // now we can do our own thing
  ...
};
// this is the delegation part
B.prototype = new A(...);
B.prototype.constructor = B;
// now we can call a super in our method
B.prototype.method = function(...){
  ...
  // time to call our super
  A.prototype.method.apply(this, arguments);
  ...
};
{% endcodeblock %}

The whole thing looks like a clumsy pattern, and patterns are usually sure signs of a weakness of an underlying
platform. Things like that are brittle, and any attempt to refactor something will involve a lot of editing.
For example, if we are to change name of a class, it will involve hunting it down and changing it everywhere.

Frequently mixins don't know (and don't care) about their immediate parents. It would be impossible to name super
methods explicitly inside mixin's methods. This consideration alone makes direct calls a poor choice for anything
but small programs.

An advantage of direct calls is obvious too &mdash; calling a super is practically static making it relatively fast:
just 2 dictionary lookups and `apply()` or `call()` overhead per call.

### Wrapper

The idea is simple: let's wrap our super-calling methods with a functional wrapper, which will set up a supercall for
us.

{% codeblock Wrapper lang:js %}
// let's write a function to generate a wrapper
function addWithWrapper(object, name, method){
  // first let's find a super
  var sup = object[name];
  // below is our wrapper, which will set this.sup to a correct value
  object[name] = function Wrapper(){
    // save old super
    var oldSup = this.sup;
    // set up a new super
    this.sup = sup;
    // now let's call our method
    try{
        var result = method.apply(this, arguments);
    }
    finally{
        // load old super back so we don't disturb other methods
        this.sup = oldSup;
    }
    return result;
  };
}

// this is how we use it
addWithWrapper(A.prototype, "method", function(a, b, c){
  ...
  // time to call our super
  if(this.sup){
    this.sup(a, b, c);
    // or: this.sup.apply(this, arguments);
  }
  ...
});
{% endcodeblock %}

Obviously the above code is a simplified implementation of that idea. It can be implemented differently.

We can see an advantage immediately: this method doesn't force us to use `apply()` or `call()` for the sake of
supplying the right object to a super method, which makes a supercall cheaper.

Cons:

* It reserves a special name for a current super method. In the example above it was `this.sup`.
* The wrapper is called once per every call to the wrapped method.
  * The wrapper function doubles a number of method calls. It is a small price for big and complex methods, but for
  small yet frequently called methods the overhead of the setup wrapper can be significant.
  * We "pay" for every call.
  * Having a wrapper affects debugging in a negative way: we have to step over the same statements inside a wrapper
  when we are debugging super-calling methods. It becomes old very fast.
* The setup code runs even if we don't use a supercall (e.g., bypassing it dynamically).

Nevertheless this is a very popular technique with OOP libraries. Some libraries apply it to every method when
constructing objects/"classes". This way we can call supers in any method without marking them up in any way.
The downside is obvious too &mdash; all methods pay "wrapper taxes" listed above.

Another popular trick is to inspect a method' source to deduce if it uses a supercall. It is a simple yet effective
optimization, which is tolerant to false positives &mdash; if we made a mistake it will cost user a performance penalty,
but doesn't break her code. Some browsers do not keep function sources for memory conservation reasons, and this trick
cannot work with them, yet such browsers are exceedingly rare nowadays.

Automatic wrapping works only when objects/"classes" were produced by a special function. If this technique is to
be used with manually created objects, it should be explicit like in the example above.

Let's spell out complexity of this method: an extra function call per a wrapped method call.

### `this.inherited()`

[Dojo][]'s `declare()` is famous for supporting such style. The idea is to have a function,
which we can call to figure out our super method:

{% codeblock this.inherited() lang:js %}
var B = declare(A, {
  method: function(...){
    ...
    // calling a super
    this.inherited(arguments);
    ...
  }
});
{% endcodeblock %}

Again the example above is over-simplified. Yet it highlights main properties of this extremely user-friendly technique:
it doesn't require any kind of special call to mark a method as super-calling, there is no mandatory wrapper,
which simplifies debugging, no performance tax to pay if a super is not called.

Cons:

* It reserves a special name. In the example above it was `this.inherited()`.
* `this.inherited()` figures out a super method dynamically.
  * The algorithm is much more complex (and more expensive) than the wrapper's one making it very expensive for small
  frequently called methods.
  * JavaScript lacks required introspection mechanisms forcing to prepare a metadata, when creating an object or
  a "class".
    * Just like with auto-wrapping above a special "class" creator function is required to produce such metadata.
* Call to a super is effectively wrapped, which is a negative factor for debugging (more unrelated code to skip).

The performance aspect can be relieved by elaborate caching mechanism, yet it cannot be more performant than a wrapper.

The complexity: one extra function call with a non-trivial algorithm inside per supercall.

### Double function/closure

So far we examined direct calls, calls using an object-wide global variable set by a wrapper, calls to an object-wide
global method that figures out our super dynamically, the only thing left is pulling it from a closure.

{% codeblock Double function lang:js %}
var B = dcl(A, {
  method: dcl.superCall(function(sup){
    return function(...){
      ...
      // calling a super
      sup.apply(this, arguments);
      ...
    };
  })
});
{% endcodeblock %}

As you can see the internal function pulls a super method from the outer function. It allows for the outer function
to be called during "class"/object creation time, it returns its internal function, which is called as a method.

Let's count pros:

* No need to reserve a name like with wrappers and `this.inherited()` techniques.
* No price to pay for methods not using supercalls both statically and dynamically.
* No price to pay for supercalls.
  * No wrappers whatsoever.
  * Debugging is completely straight-forward.

Cons:

* The pattern looks weird. It can be mistyped.
* All super-calling methods should be converted to it.
  * There is no automation like with other techniques.
* Super-calling methods are not directly usable.
  * A "class" creator function is required that should instantiate necessary super-calling methods.

## Discussion

All techniques have pros and cons. Usually a programmer makes a conscience decision selecting strong features and
trade-offs, which are right for their application. A library writer cannot afford to make choices that penalize
application developers. An example of such decision would be a performance.

Out of last three techniques the double function one is virtually without a run-time penalty per call (only a small
setup "fee" per "class" is expected), and makes debugging comfortable. Thus it was selected to be implemented as
a major mechanism for supercalls: [dcl.superCall()](/docs/mini_js/supercall).

Building on experience with [Dojo][] `this.inherited()` technique was selected for implementation too:
[inherited.js](/docs/inherited_js). Its strong suit is user-friendliness, and known price per supercall,
while method calls come always for free.

Both implemented methods do not tax programmers, who do not use these facilities.

The double function technique is recommended for all new code, while the `this.inherited()` technique is more suitable
when refactoring legacy code because it doesn't require much modification to call a super method. Working with
an existing codebase a programmer can start by converting their "classes" to [dcl()](/docs/mini_js/dcl) syntax, and
calling super methods with `this.inherited()`, while the final product should use the double function technique.

[Dojo]:  http://dojotoolkit.org  Dojo
