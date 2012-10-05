---
layout: page
title: "dcl.Super"
date: 2012-07-21 13:52
comments: false
sharing: true
footer: true
---

This is a constructor, which serves as a foundation of method decorators used by `dcl`. It is not intended to be
used by end-users, and useful only for extending `dcl` itself.

## Description

Method decorators produce objects based on `dcl.Super`. It is only useful for extending `dcl`.

By default a decorated method is exposed as a property `f` on a decorator object.

## Examples

{% codeblock Using dcl.Super lang:js %}
for(var name in o){
  var m = o[name];
  if(m && m instanceof dcl.Super){
    console.log("Method " + name + " is decorated.");
    console.log("It has " + m.f.length + " arguments.");
  }
}
{% endcodeblock %}
