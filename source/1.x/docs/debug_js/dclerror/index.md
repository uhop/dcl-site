---
layout: page
title: "dclDebug.DclError"
date: 2012-07-29 00:12
comments: false
sharing: true
footer: true
---

*Version 1.x*

`dclDebug.DclError` serves as a base class for all other exceptions thrown by
`dcl`. It can be used to identify `dcl`-produced errors.

## Examples

{% codeblock dclDebug.DclError lang:js %}
var dclDebug = require("dcl/debug");

try{
  // ... dcl-related code
}catch(e){
  if(e instanceof dclDebug.DclError){
    // special treatment
  }
}
{% endcodeblock %}

Other exceptions are based on it:

* [dclDebug.CycleError](../debug_js/cycleerror) - *thrown when there is an unresolvable cycle in list of
  declared bases*
* [dclDebug.ChainingError](../debug_js/chainingerror) - *thrown when composing a class with different chaining
  directives for the same method*
* [dclDebug.SetChainingError](../debug_js/setchainingerror) - *thrown when setting a conflicting chaining*
* [dclDebug.SuperCallError](../debug_js/supercallerror) - *thrown when an argument of
  [dcl.superCall()](../mini_js/supercall) or [dcl.around()](../dcl_js/around) decorators is not a function*
* [dclDebug.SuperError](../debug_js/supererror) - *thrown when the next-in-line property is not a function, and
  a super call cannot be made*
* [dclDebug.SuperResultError](../debug_js/superresulterror) - *thrown when an argument of
  [dcl.superCall()](../mini_js/supercall) or [dcl.around()](../dcl_js/around) decorators does not return
  a function (likely the double function pattern was not followed &mdash; see [dcl.superCall()](../mini_js/supercall)
  for details)*
