---
layout: page
title: "advise.after()"
date: 2012-07-29 00:04
comments: false
sharing: true
footer: true
---

*Version 1.x*

This is a convenience function to weave an `after` advice based on [advise()](../advise_js/advise).

## Description

This is a shortcut function to weave one `after` advice with an object's method. Logically it is defined as:

{% codeblock advise.after() lang:js %}
advise.after = function(object, name, advice){
  return advise(object, name, {
    after: advice
  });
};
{% endcodeblock %}

It means that instead of:

{% codeblock Long lang:js %}
var adv = advise(object, name, {
  after: advice
});
{% endcodeblock %}

It is possible to write a shorter version:

{% codeblock Short lang:js %}
var adv = advice.after(object, name, advice);
{% endcodeblock %}

### Advice function

This type of advice is a regular function. It is called with the same context as an advised method. It takes
two parameters: `args` is an `arguments` object (a pseudo-array) used to call an advised method, and `result`,
which is a returned value or a thrown exception object. Its returned value is ignored.

It is not recommended to modify parameters or a returned value inside `after` advice. Use `around` advice for that.

It is recommended to derive all exception objects from the standard `Error` object, so erroneous and normal
result values would be distinct.

### Returned value

Just like [advise()](../advise_js/advise) it is based on, it returns an opaque object with a single method:
`unadvise()`. Calling it without parameters removes all advices set with that call to `advise()`.

In order to be compatible with general destruction mechanisms it defines one more method: `destroy()`, which is
an alias to `unadvise()`.
