---
layout: page
title: "trace()"
date: 2017-06-08 13:55
comments: false
sharing: true
footer: true
---

*Version 2.x*

`trace(name, level)` prints a trace log using `console.log()`. It is used mainly for debugging. Included details:

* instance
* parameters
* result values (both normally returned and thrown exceptions)

All objects are printed using indirect calls to their respective `toString()` methods.

It is defined in `dcl/advices/trace.js`.

## Description

The result value of `trace` module is a function, which takes two parameters. The first parameter `name` is a string that is used to indicate a method call. Usually it is a method name. The second optional parameter `level` is a Boolean value. If it is true, a level number is printed and indentation is used to indicate how method calls are embedded. Otherwise (the default), the level information is not printed.

It returns an advice object, which can be used directly with [dcl.advise()](/2.x/docs/dcl_js/advise/) or [advise()](/2.x/docs/advise_js/advise/).

## Examples

Class-level example:

{% codeblock trace Ackermann class-level example lang:js %}
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
  },
  toString: function () { return "Ackermann"; }
});

var InstrumentedAckermann = dcl(Ackermann, {
  declaredName: "InstrumentedAckermann",
  m0: dcl.advise(trace("m0")),
  n0: dcl.advise(trace("n0")),
  a:  dcl.advise(trace("a"))
});

var x = new InstrumentedAckermann();
x.a(1, 1);
{% endcodeblock %}

The example above will print:

{% codeblock output 1 lang:text %}
Ackermann => a(1, 1)
Ackermann => a(1, 0)
Ackermann => n0(1)
Ackermann => a(0, 1)
Ackermann => m0(1)
Ackermann => m0 returns 2
Ackermann => a returns 2
Ackermann => n0 returns 2
Ackermann => a returns 2
Ackermann => a(0, 2)
Ackermann => m0(2)
Ackermann => m0 returns 3
Ackermann => a returns 3
Ackermann => a returns 3
{% endcodeblock %}

Object-level example:

{% codeblock trace Ackermann object-level example lang:js %}
// our instance:
var x = new Ackermann();

advise(x, "m0", trace("m0", true));
advise(x, "n0", trace("n0", true));
advise(x, "a",  trace("a",  true));

x.a(1, 1);
{% endcodeblock %}

The example above will print:

{% codeblock output 2 lang:text %}
1 Ackermann => a(1, 1)
2   Ackermann => a(1, 0)
3     Ackermann => n0(1)
4       Ackermann => a(0, 1)
5         Ackermann => m0(1)
5         Ackermann => m0 returns 2
4       Ackermann => a returns 2
3     Ackermann => n0 returns 2
2   Ackermann => a returns 2
2   Ackermann => a(0, 2)
3     Ackermann => m0(2)
3     Ackermann => m0 returns 3
2   Ackermann => a returns 3
1 Ackermann => a returns 3
{% endcodeblock %}
