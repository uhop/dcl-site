---
layout: page
title: "dcl.isSuper()"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

This function returns `true`/`false` for decorated properties. It is not intended to be
used by end-users, and useful only for extending `dcl` itself.

## Description

`dcl.isSuper(f)` returns a Boolean value: `true`, if its argument is a decorated function, and `false` otherwise. It is exposed solely for a use by possible preprocessors for `dcl`.

## Notes

It is defined in terms [dcl.Super](super):

{% codeblock Implementation of dcl.isSuper() lang:js %}
dcl.isSuper = function (f) {
  return f && f.spr instanceof dcl.Super;
};
{% endcodeblock %}
