---
layout: page
title: "advise.before()"
date: 2017-06-05 00:04
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a convenience function to weave a `before` advice based on [advise()](/2.x/docs/advise_js/advise/).

## Description

This is a shortcut function to weave one `before` advice with an object's method. Logically it is defined as:

{% codeblock advise.before() lang:js %}
advise.before = function(object, name, advice){
  return advise(object, name, {
    before: advice
  });
};
{% endcodeblock %}

It means that instead of:

{% codeblock Long lang:js %}
var adv = advise(object, name, {
  before: advice
});
{% endcodeblock %}

It is possible to write a shorter version:

{% codeblock Short lang:js %}
var adv = advise.before(object, name, advice);
{% endcodeblock %}

### Advice function

This type of advice is a regular function. It is called with the same context and the same arguments as
an advised method. Its return value is ignored.

It is not recommended to modify parameters inside `before` advice. Use `after` or `around` advice for that.

### Returned value

Just like [advise()](/2.x/docs/advise_js/advise/) it is based on, it returns the object, which defines the method `unadvise()`. When called without parameters, it removes the corresponding advice from the object, no matter when it was defined. For convenience, this method is aliased as `remove()`, and `destroy()`.
