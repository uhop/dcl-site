---
layout: page
title: "trace()"
date: 2012-07-29 13:55
comments: false
sharing: true
footer: true
---

`trace()` prints a trace log using `console.log()`. It is used mainly for debugging.
Included details:

* instance
* parameters
* result values (both normally returned and thrown exceptions)

All objects are printed using indirect calls to their respective `toString()` methods.

It can be included with following commands:

{% codeblock Include trace() lang:js %}
// node.js
var trace = require("dcl/advices/trace");
...

// AMD (code)
require(["dcl/advices/trace"], function(trace){
  ...
});

// AMD (definition)
define(["dcl/advices/trace"], function(trace){
  ...
});
{% endcodeblock %}

## Description

The result value of `trace` module is a function, which takes two parameters.
The first parameter `name` is a string that is used to indicate a method call.
Usually it is a method name. The second optional parameter `level` is
a Boolean value. If it is true, a level number is printed and indentation is used
to indicate how method calls are embedded. Otherwise (the default), the level
information is not printed.

It returns an advice object, which can be used directly with
[dcl.advise()](/docs/dcl_js/advise) or [advise()](/docs/advise_js/advise).

## Examples

Class-level example:

{% codeblock trace Ackermann class-level example lang:js %}
var Ackermann = dcl(null, {
  declaredName: "Ackermann",
  m0: function(n){
    return n + 1;
  },
  n0: function(m){
    return this.a(m - 1, 1);
  },
  a: function(m, n){
    if(m == 0){
      return this.m0(n);
    }
    if(n == 0){
      return this.n0(m);
    }
    return this.a(m - 1, this.a(m, n - 1));
  }
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

{% codeblock %}
[object Object] => a(1, 1)
[object Object] => a(1, 0)
[object Object] => n0(1)
[object Object] => a(0, 1)
[object Object] => m0(1)
[object Object] => m0 returns 2
[object Object] => a returns 2
[object Object] => n0 returns 2
[object Object] => a returns 2
[object Object] => a(0, 2)
[object Object] => m0(2)
[object Object] => m0 returns 3
[object Object] => a returns 3
[object Object] => a returns 3
{% endcodeblock %}

Object-level example:

{% codeblock trace Ackermann object-level example lang:js %}
var Ackermann = dcl(null, {
  declaredName: "Ackermann",
  m0: function(n){
    return n + 1;
  },
  n0: function(m){
    return this.a(m - 1, 1);
  },
  a: function(m, n){
    if(m == 0){
      return this.m0(n);
    }
    if(n == 0){
      return this.n0(m);
    }
    return this.a(m - 1, this.a(m, n - 1));
  }
});

// our instance:
var x = new Ackermann();

advise(x, "m0", trace("m0", true));
advise(x, "n0", trace("n0", true));
advise(x, "a",  trace("a",  true));

x.a(1, 1);
{% endcodeblock %}

The example above will print:

{% codeblock %}
1 [object Object] => a(1, 1)
2   [object Object] => a(1, 0)
3     [object Object] => n0(1)
4       [object Object] => a(0, 1)
5         [object Object] => m0(1)
5         [object Object] => m0 returns 2
4       [object Object] => a returns 2
3     [object Object] => n0 returns 2
2   [object Object] => a returns 2
2   [object Object] => a(0, 2)
3     [object Object] => m0(2)
3     [object Object] => m0 returns 3
2   [object Object] => a returns 3
1 [object Object] => a returns 3
{% endcodeblock %}
