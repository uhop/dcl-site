---
layout: page
title: "advise.around()"
date: 2017-06-05 00:04
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a convenience function to weave an `around` advice based on [advise()](advise).

## Description

This is a shortcut function to weave one `around` advice with an object's method. Logically it is defined as:

{% codeblock dcl.around() lang:js %}
advise.around = function(object, name, advice){
  return advise(object, name, {
    around: advice
  });
};
{% endcodeblock %}

It means that instead of:

{% codeblock Long lang:js %}
var adv = advise(object, name, {
  around: advice
});
{% endcodeblock %}

It is possible to write a shorter version:

{% codeblock Short lang:js %}
var adv = advice.around(object, name, advice);
{% endcodeblock %}

### Advice function

Essentially it is the same as [dcl.superCall()](../dcl_js/supercall), but applied dynamically to an object. It uses the same double function pattern, and its behavior is the same.

### Returned value

Just like [advise()](advise) it is based on, it returns the object, which defines the method `unadvise()`. When called without parameters, it removes the corresponding advice from the object, no matter when it was defined. For convenience, this method is aliased as `remove()`, and `destroy()`.

## Notes

Don't forget that **around advices always follow the double function pattern**:

{% codeblock Around advice lang:js %}
function aroundAdvice (sup) {
  return function (...) {...};
}
{% endcodeblock %}

See details in [dcl.superCall()](../dcl_js/supercall), [dcl.advise()](../dcl_js/advise), and
[advise()](advise).
