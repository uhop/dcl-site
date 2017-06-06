---
layout: page
title: "advise()"
date: 2017-06-05 00:04
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a function that weaves AOP advices dynamically. Unlike [dcl.advise()](../dcl_js/advise)
it works on objects, rather than when defining "classes". All advices can be "unadvised" at any moment.

## Description

`advise()` is a function, which takes three parameters:

* `obj` - the object to advise. Any object would do, including objects produced without `dcl`-made constructors.
* `name` - the method name. If the method had AOP advices defined by [dcl()](../dcl_js/dcl), and/or previous calls
to `advise()`, they will be properly combined.
* `advice` - the object with properties `before`, `around`, and/or `after`. See [dcl.advise()](../dcl_js/advise) for more details.

It returns the object, which defines the method `unadvise()`. When called without parameters, it removes the corresponding advice from the object, no matter when it was defined. For convenience, this method is aliased as `remove()`, and `destroy()`.

How to use advices is described in details in [dcl.advise()](../dcl_js/advise).

{% codeblock advise() lang:js %}
var a = {
  method: function (msg) { cosole.log("MSG: " + msg); }
};

var methodAdv = advise(a, "method", {
  before: function (msg) {
    console.log("Method was called with msg = " + msg);
  },
  after: function (args, result) {
    console.log("Method has finished.");
  },
  around: function (sup) {
    return function (msg) {
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

Like [dcl.advise()](../dcl_js/advise), `advise()` can be used to advise getters and setters. Unlike [dcl.advise()](../dcl_js/advise), it cannot dynamically convert values to getters, and getters to values. So if you want to advise a getter (or a setter), they should be already defined.

{% codeblock advise() with getters/setters lang:js %}
var a = {
  get x ()  { return this.v || 0; },
  set x (v) { this.v = v; }
};

var propAdv = advise(a, "x", {
  get: {
    before: function () {
      console.log("getting x");
    },
    after: function () {
      console.log("Getter has finished.");
    },
    around: function(sup){
      return function(){
        return 2 * sup.call(this);
      };
    }
  },
  set: {
    before: function (v) {
      console.log("setting x to " + v);
    },
    after: function () {
      console.log("Setter has finished.");
    }
  }
});
{% endcodeblock %}

## Examples

{% codeblock advise() changes return values lang:js %}
var a = ...;

advise(a, 'm', {
  after: function (args, result, makeReturn, makeThrow) {
    if (result % 2) {
      makeReturn(1);
      return;
    }
    makeThrow(new Error("evil even number!"));
  }
});
{% endcodeblock %}

## Notes

### Shortcuts

If you want to weave just one advice, you may want to use a shortcut:

{% codeblock advise.before() lang:js %}
advise.before(a, "method", function (msg) {
  console.log("Method was called with msg = " + msg);
});
// is equivalent to
advise(a, "method", {
  before: function (msg) {
    console.log("Method was called with msg = " + msg);
  }
});
{% endcodeblock %}

{% codeblock advise.after() lang:js %}
advise.after(a, "method", function () {
  console.log("Method has finished.");
});
// is equivalent to
advise(a, "method", {
  after: function () {
    console.log("Method has finished.");
  }
});
{% endcodeblock %}

{% codeblock advise.around() lang:js %}
advise.around(a, "method", function (sup) {
  return function (msg) {
    // let's ignore our parameter
    sub.call(this, "Canned response no matter what.");
  };
});
// is equivalent to
advise(a, "method", {
  around: function (sup) {
    return function (msg) {
      // let's ignore our parameter
      sub.call(this, "Canned response no matter what.");
    };
  }
});
{% endcodeblock %}

You can find those methods documented respectively in [advise.before()](before),
[advise.after()](after), and [advise.around()](around).
