---
layout: page
title: "dcl.around()"
date: 2012-07-29 00:07
comments: false
sharing: true
footer: true
---

This is a convenience decorator to define a `around` advice.

## Description

This is a shortcut function to define one `around` advice. Logically it is defined as a synonym for
[dcl.superCall()](/docs/mini_js/supercall):

{% codeblock dcl.before() lang:js %}
dcl.around = function(advice){
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

## Notes

Do not forget to use the double function pattern for an `around` advice. See details in
[dcl.superCall()](/docs/mini_js/supercall) and in [dcl.advise()](/docs/dcl_js/advise).
