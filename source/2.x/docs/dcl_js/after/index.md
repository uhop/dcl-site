---
layout: page
title: "dcl.after()"
date: 2017-06-04 00:07
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a convenience decorator to define a `after` advice based on [dcl.advise()](advise).

## Description

This is a shortcut function to define one `after` advice. Logically it is defined as:

{% codeblock dcl.after() lang:js %}
dcl.after = function (advice) {
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

This is a regular function. It is called with the same context as an advised method. It takes up to four parameters:

* `args` - the `arguments` object (a pseudo-array) used to call an advised method.
* `result` - the returned value or a thrown exception object.
* `makeReturn(value)` - the procedure, which can be called to supply a new returned value.
* `makeThrow(value)` - the procedure, which can be called to emulate an exception. In this case `value` is assumed to be a valid exception value, e.g., an `Error` object.

Both `makeReturn()` and `makeThrow()` can be called several times. The last value is used as the result.

The returned value of an after advice is ignored.

It is not recommended to modify parameters or a returned value inside `after` advice. Use `makeReturn()`, or `makeThrow()` for that. Or consider using `around` advice.

It is recommended to derive all exception objects from the standard `Error` object, so erroneous and normal
result values would be easily distinguished.
