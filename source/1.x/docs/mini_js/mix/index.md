---
layout: page
title: "dcl.mix()"
date: 2012-07-21 13:52
comments: false
sharing: true
footer: true
---

*Version 1.x*

This is a utility function that does a shallow copy of properties from one object to another. It is used inside `dcl`
and exposed because it is frequently required by user's code.

## Description

It copies properties from one object to another. The copy is shallow and does not involve cloning of objects.

The best way to describe `dcl.mix()` is to give its definition:

{% codeblock dcl.mix() lang:js %}
dcl.mix = function(a, b){
  for(var n in b){
    a[n] = b[n];
  }
};
{% endcodeblock %}

## Examples

{% codeblock Mix-in constants lang:js %}
dcl.mix(x, {a: 1, b: 2, c: "hello!"});
{% endcodeblock %}

## Notes

Even for totally empty objects IE6 lists some internal methods. Usually copying of these methods does no harm
to objects.