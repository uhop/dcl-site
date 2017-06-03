---
layout: page
title: "dcl.after()"
date: 2012-07-29 00:07
comments: false
sharing: true
footer: true
---

*Version 1.x*

This is a convenience decorator to define a `after` advice based on [dcl.advise()](../dcl_js/advise).

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

### Advice function

This type of advice is a regular function. It is called with the same context as an advised method. It takes
two parameters: `args` is an `arguments` object (a pseudo-array) used to call an advised method, and `result`,
which is a returned value or a thrown exception object. Its returned value is ignored.

It is not recommended to modify parameters or a returned value inside `after` advice. Use `around` advice for that.

It is recommended to derive all exception objects from the standard `Error` object, so erroneous and normal
result values would be distinct.
