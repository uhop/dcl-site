---
layout: page
title: "advise()"
date: 2012-07-29 00:04
comments: false
sharing: true
footer: true
---

*Version 1.x*

This is a function that weaves AOP advices dynamically. Unlike [dcl.advise()](/1.x/docs/dcl_js/advise/)
it works on objects, rather than "classes". All advices can be "unadvised" at any moment.

## Description

`advise()` is a function, which takes an object with properties `before`, `around`, and/or `after`, and
combines an existing method with supplied advices.

{% codeblock advise() lang:js %}
var a = ...

var methodAdv = advise(a, "method", {
  before: function(msg){
    console.log("Method was called with msg = " + msg);
  },
  after: function(args, result){
    console.log("Method has finished.");
  },
  around: function(sup){
    return function(msg){
      // let's ignore our parameter
      sub.call(this, "Canned response no matter what.");
    };
  }
});

a.method("Hey!");
// Method was called with msg = Hey!
// MSG: Canned response no matter what.
// Method has finished.

methodAdv.unadvise();
// Now all previous advices are removed from the object.
{% endcodeblock %}

Advices are functions with following properties.

### Before

This is a regular function. It is called with the same context and the same arguments as an advised method.
Its return value is ignored.

It is not recommended to modify parameters inside `before` advice. Use `around` advice for that.

### After

This is a regular function. It is called with the same context as an advised method. It takes two parameters: `args` is
an `arguments` object (a pseudo-array) used to call an advised method, and `result`, which is a returned value or
a thrown exception object. Its returned value is ignored.

It is not recommended to modify parameters or a returned value inside `after` advice. Use `around` advice for that.

It is recommended to derive all exception objects from the standard `Error` object, so erroneous and normal
result values would be distinct.

### Around

Essentially this advice is the same as [dcl.superCall()](/1.x/docs/mini_js/supercall/). It uses the same double
function pattern, and its behavior is the same.

### Order of advices

Advices are always applied in the following order regardless of their declaration order:

1. Advices created with [dcl.advise()](/1.x/docs/dcl_js/advise/) and `advise()` are equivalent in all respects.
2. All `before` advices go first in the reverse chronological order (the last one goes first).
3. All `around` advices go next in the reverse chronological order (the last one goes first). The next `around` advice
is called only if its previous `around` advice yielded control explicitly by calling its super method.
4. All `after` advices go last in the chronological order (the first one goes first).

### Return value

`advise()` returns an opaque object with a single method: `unadvise()`. Calling it without parameters removes all
advices set with that call to `advise()`.

In order to be compatible with general destruction mechanisms it defines one more method: `destroy()`, which is
an alias to `unadvise()`.

## Notes

### Shortcuts

If you want to weave just one advice, you may want to use a shortcut:

{% codeblock AOP shortcuts lang:js %}
advise.before(a, "method", function(msg){
  console.log("Method was called with msg = " + msg);
});
// is equivalent to
advise(a, "method", {
  before: function(msg){
    console.log("Method was called with msg = " + msg);
  }
});

advise.after(a, "method", function(args, result){
  console.log("Method has finished.");
});
// is equivalent to
advise(a, "method", {
  after: function(args, result){
    console.log("Method has finished.");
  }
});

advise.around(a, "method", function(sup){
  return function(msg){
    // let's ignore our parameter
    sub.call(this, "Canned response no matter what.");
  };
});
// is equivalent to
advise(a, "method", {
  around: function(sup){
    return function(msg){
      // let's ignore our parameter
      sub.call(this, "Canned response no matter what.");
    };
  }
});
{% endcodeblock %}

You can find those methods documented respectively in [advise.before()](/1.x/docs/advise_js/before/),
[advise.after()](/1.x/docs/advise_js/after/), and [advise.around()](/1.x/docs/advise_js/around/).
