---
layout: page
title: "advise.around()"
date: 2012-07-29 00:04
comments: false
sharing: true
footer: true
---

*Version 1.x*

This is a convenience function to weave an `around` advice based on [advise()](/1.x/docs/advise_js/advise/).

## Description

This is a shortcut function to weave one `around` advice with an object's method. Logically it is defined as:

{% codeblock advise.around() lang:js %}
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
var adv = advise.around(object, name, advice);
{% endcodeblock %}

### Advice function

Essentially it is the same as [dcl.superCall()](/1.x/docs/mini_js/supercall/). It uses the same double function pattern,
and its behavior is the same.

### Returned value

Just like [advise()](/1.x/docs/advise_js/advise/) it is based on, it returns an opaque object with a single method:
`unadvise()`. Calling it without parameters removes all advices set with that call to `advise()`.

In order to be compatible with general destruction mechanisms it defines one more method: `destroy()`, which is
an alias to `unadvise()`.

## Notes

Don't forget that **around advices always follow the double function pattern**:

{% codeblock Around advice lang:js %}
function aroundAdvice(sup){
  return function(...){...};
}
{% endcodeblock %}

See details in [dcl.superCall()](/1.x/docs/mini_js/supercall/), [dcl.advise()](/1.x/docs/dcl_js/advise/). and
[advise()](/1.x/docs/advise_js/advise/).
