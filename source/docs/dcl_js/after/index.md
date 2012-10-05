---
layout: page
title: "dcl.after()"
date: 2012-07-29 00:07
comments: false
sharing: true
footer: true
---

This is a convenience decorator to define a `after` advice.

## Description

This is a shortcut function to define one `after` advice. Logically it is defined as:

{% codeblock dcl.after() lang:js %}
dcl.after = function(advice){
  return dcl.advise({
    after: advice
  });
};
{% endcodeblock %}

It means that instead of:

{% codeblock Long lang:js %}
method: dcl.advise({
  after: advice
})
{% endcodeblock %}

It is possible to write a shorter version:

{% codeblock Short lang:js %}
method: dcl.after(advice)
{% endcodeblock %}
