---
layout: page
title: "dcl.Advice"
date: 2012-07-29 00:06
comments: false
sharing: true
footer: true
---

*Version 1.x*

This is a constructor, which serves as a foundation of method decorators used by `dcl.advise()`.
It is not intended to be used by end-users, and useful only for extending `dcl` itself.

## Description

`dcl.advise()` produces objects based on `dcl.Advice`, which, in turn, is derived from [dcl.Super](/1.x/docs/mini_js/super/).
It is only useful for extending `dcl`.

By default a "before" advice (if present) is exposed as a property `b` on a decorator object, an "after" advice as
a property `a`, and an "around" advice as a property `f`.

## Examples

{% codeblock Using dcl.Advice lang:js %}
for(var name in o){
  var m = o[name];
  if(m && m instanceof dcl.Advice){
    console.log("Method " + name + " is decorated with AOP advices.");
    console.log("Before advice is " + (m.b ? "present" : "not present"));
    console.log("After  advice is " + (m.a ? "present" : "not present"));
    console.log("Around advice is " + (m.f ? "present" : "not present"));
  }
}
{% endcodeblock %}

The example above is not going to work on fully constructed objects because by that time all `dcl.Super` objects
would be replaced by generated functions.
