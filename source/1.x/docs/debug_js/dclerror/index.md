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

* [dclDebug.CycleError](/1.x/docs/debug_js/cycleerror/) - *thrown when there is an unresolvable cycle in list of
  declared bases*
* [dclDebug.ChainingError](/1.x/docs/debug_js/chainingerror/) - *thrown when composing a class with different chaining
  directives for the same method*
* [dclDebug.SetChainingError](/1.x/docs/debug_js/setchainingerror/) - *thrown when setting a conflicting chaining*
* [dclDebug.SuperCallError](/1.x/docs/debug_js/supercallerror/) - *thrown when an argument of
  [dcl.superCall()](/1.x/docs/mini_js/supercall/) or [dcl.around()](/1.x/docs/dcl_js/around/) decorators is not a function*
* [dclDebug.SuperError](/1.x/docs/debug_js/supererror/) - *thrown when the next-in-line property is not a function, and
  a super call cannot be made*
* [dclDebug.SuperResultError](/1.x/docs/debug_js/superresulterror/) - *thrown when an argument of
  [dcl.superCall()](/1.x/docs/mini_js/supercall/) or [dcl.around()](/1.x/docs/dcl_js/around/) decorators does not return
  a function (likely the double function pattern was not followed &mdash; see [dcl.superCall()](/1.x/docs/mini_js/supercall/)
  for details)*
