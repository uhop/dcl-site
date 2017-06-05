---
layout: page
title: "dcl.before()"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a convenience decorator to define a `before` advice based on [dcl.advise()](advise).

## Description

This is a shortcut function to define one `before` advice. Logically it is defined as:

{% codeblock dcl.before() lang:js %}
dcl.before = function (advice) {
  return dcl.advise({
    before: advice
  });
};
{% endcodeblock %}

It means that instead of:

{% codeblock Long lang:js %}
method: dcl.advise({
  before: advice
})
{% endcodeblock %}

It is possible to write a shorter version:

{% codeblock Short lang:js %}
method: dcl.before(advice)
{% endcodeblock %}

### Advice function

This type of advice is a regular function. It is called with the same context and the same arguments as
an advised method. Its return value is ignored.

It is not recommended to modify parameters inside `before` advice. Use `after` or `around` advice for that.
