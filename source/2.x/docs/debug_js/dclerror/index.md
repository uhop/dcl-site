---
layout: page
title: "dcl.DclError"
date: 2017-06-09 00:12
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl.DclError` serves as the base class for all other exceptions thrown by `dcl`. It can be used to identify `dcl`-produced errors. It is present only when `dcl/debug` is imported. Otherwise, `Error` will be thrown.

## Examples

{% codeblock dcl.DclError lang:js %}
var dcl = require("dcl/debug");

try {
  // ... dcl-related code
} catch (e) {
  if (e instanceof dcl.DclError) {
    // special treatment
  }
}
{% endcodeblock %}

Other exceptions are based on it:

* [dcl.CycleError](/2.x/docs/debug_js/cycleerror/) - *thrown when there is an unresolvable cycle in list of declared bases*
* [dcl.SuperError](/2.x/docs/debug_js/supererror/) - *thrown when the next-in-line property is not a function, and a super call cannot be made*
* [dcl.ChainingError](/2.x/docs/debug_js/chainingerror/) - *thrown when composing a class with different chaining directives for the same method*
