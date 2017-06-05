---
layout: page
title: "dcl.around()"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a convenience decorator to define a `around` advice based on [dcl.advise()](advise).

## Description

This is a shortcut function to define one `around` advice. Logically it is defined as a synonym for
[dcl.superCall()](supercall):

{% codeblock dcl.around() lang:js %}
dcl.around = function (advice) {
  return dcl.superCall(advice);
};
{% endcodeblock %}

It means that instead of:

{% codeblock Long lang:js %}
method: dcl.advise({
  around: advice
})
{% endcodeblock %}

It is possible to write a shorter version:

{% codeblock Short lang:js %}
method: dcl.around(advice)
{% endcodeblock %}

Of course you can always do it like that too:

{% codeblock Supercall lang:js %}
method: dcl.superCall(advice)
{% endcodeblock %}

### Advice function

Essentially it is the same as [dcl.superCall()](supercall). It uses the same double function pattern,
and its behavior is the same.

## Notes

Do not forget to use the double function pattern for an `around` advice. See details in
[dcl.superCall()](supercall) and in [dcl.advise()](advise).
