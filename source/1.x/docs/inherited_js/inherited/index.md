---
layout: page
title: "inherited()"
date: 2012-07-29 00:15
comments: false
sharing: true
footer: true
---

*Version 1.x*

This function calls a super method dynamically.

While it is slower than the normal way to do supercalls with `dcl` (see the decorator
[dcl.superCall()](../mini_js/supercall) for details), it doesn't require to modify
a method according to the double function pattern, and can be applied to
undecorated methods, which makes it suitable for fast prototyping, and
transitioning legacy code.

As soon as `inherited.js` is included, it mixes in `inherited()` as a method to all
newly created objects, so you don't need to use the result of the module directly.

`inherited()` can be used in strict mode.

## Description

Unlike the decorator [dcl.superCall()](../mini_js/supercall), which supplies
a supercall method statically, `inherited()` does the same dynamically at some
run-time expense. While doing so, it doesn't require to decorate a method, and
can be used to add a supercall to any arbitrary method, which makes it suitable
for transitioning legacy code or fast prototyping:

{% codeblock inherited() lang:js %}
var B = dcl(A, {
  // The inherited() way:
  calcPrice1: function(x){
      // Let's inflate price by 200%.
      // Asking for a real price in three different yet equivalent ways:
    var realPrice1 = this.inherited(arguments);
    var realPrice2 = this.inherited(arguments, [x]);
    var realPrice3 = this.inherited(B, "calcPrice1", [x]);
    // Now let's return it tripled.
    return realPrice1 + realPrice2 + realPrice3;
  },

  // Compare it with dcl.superCall() example:
  calcPrice2: dcl.superCall(function(sup){
      // Let's inflate price by 200%.
    return function(x){
      // In this example we don't check if `sup` is truthy:
      // imagine that we know that statically.
        // Asking for a real price in three different yet equivalent ways:
      var realPrice1 = sup.apply(this, arguments);
      var realPrice2 = sup.apply(this, [x]);
      var realPrice3 = sup.call(this, x);
      // Now let's return it tripled:
      return realPrice1 + realPrice2 + realPrice3;
    };
  }),

  // Another alternative is to use getInherited():
  calcPrice3: function(x){
    var sup = this.getInherited(B, "calcPrice3");
    // In this example we don't check if `sup` is truthy:
    // imagine that we know that statically.
      // Let's inflate price by 200%.
      // Asking for a real price in three different yet equivalent ways:
    var realPrice1 = sup.apply(this, arguments);
    var realPrice2 = sup.apply(this, [x]);
    var realPrice3 = sup.call(this, x);
    // Now let's return it tripled:
    return realPrice1 + realPrice2 + realPrice3;
  }
});
{% endcodeblock %}

As you can see `calcPrice1()` is a simple undecorated method, `calcPrice2()` is
the fastest way to do supercalls, and `calcPrice3()` is similar to `calcPrice1()`
yet employs a simple optimization technique: determines a supercall once instead
of three times and reuses its result.

The example above demonstrates three possible ways to use `inherited()`:

1. `this.inherited(arguments)` is probably the most common case: it calls a super method
   with the same arguments as the current methods. Effectively it is a pass-through.
   This style of code **cannot be used in strict mode**.
2. `this.inherited(arguments, [x])` uses `arguments` only to figure out a super method,
   which will be called with following array of arguments: `[x]`. It is a way to call
   a super with a custom list of arguments. This style of code **cannot be used in
   strict mode**.
3. `this.inherited(B, "calcPrice3", [x])` is a direct way to identify what super method
   should be used. In this example `B` is a constructor object for a class with
   our method, `"calcPrice3"` is a name of that method, and `[x]` is an arbitrary array
   of parameters we want to pass. This style of code **works perfectly in strict mode**.
   * The downside of this method is a necessity to specify method's name explicitly.
     Usually it is known statically, so it is not a problem, yet it may make method
     renaming error-prone.
   * **Remember**: a constructor and a name specify a method that calls its super,
     not its super method. It cannot name a method different from a current method!

`inherited()` returns a result returned by a super method, whatever it may be.
If there is no super method, the call is essentially a no-op and returns `undefined`.
If you want to check for an existance of a super method,
use [getInherited()](../inherited_js/getinherited).

## Notes

1. If a method is present in an `Object`, it will be the last in line of potential
   super calls.
2. If a super method throws an exception, it is a programmer's responsibility
   to catch it, to ignore it, or to pass it through.

## FAQ

### Can I call built-in functions with `inherited()`?

Yes.

{% codeblock Calling toString() lang:js %}
// non-strict mode
var A = dcl(null, {
  toString: function(){
    return "prefix-" + this.inherited(arguments) + "-postfix";
  }
});

// strict mode
var B = dcl(null, {
  toString: function(){
    return "prefix-" + this.inherited(B, "toString") + "-postfix";
  }
});
{% endcodeblock %}

### Can I use `inherited()` in a chained method?

No. It is meant mostly for legacy scenarios. While it doesn't fail, `inherited()`
will not break a chain, and your chained method can be called twice.

### How can I organize pass-through in strict mode?

If you want to call a super method with the same array of arguments as you received,
just pass `arguments` object as your array of arguments:

{% codeblock Calling Pass-through lang:js %}
// non-strict mode
var B = dcl(A, {
  method: function(){
    return this.inherited(arguments);
  }
});

// strict mode
var C = dcl(B, {
  method: function(){
    return this.inherited(C, "method", arguments);
  }
});
{% endcodeblock %}
