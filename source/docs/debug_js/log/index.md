---
layout: page
title: "dclDebug.log()"
date: 2012-07-29 00:12
comments: false
sharing: true
footer: true
---

The main method of this module logs on console debugging details about an object.
Provided details includes an ordered list of dependencies, super calls, and
both class-level and object-level AOP advises.

## Description

Working with non-trivial inheritance chains can be puzzling. While the C3 MRO algorithm
used by `dcl` takes care of duplicates and ordering of mixins, in some cases programmer
needs to know exact details of such linearization.

Even more puzzling can be ordering of call chains, and/or advices both static and dynamic.

`dclDebug.log()` provides both types of information, and inspects what constructor was used
to create an object.

## Examples

{% codeblock dclDebug.log() lang:js %}
var dcl      = require("dcl"),
	advise   = require("dcl/advise"),
	dclDebug = require("dcl/debug");

// A defines an "after" advise
var A = dcl(null, {
  declaredClass: "A",
  sleep: dcl.after(function(){
    console.log("*zzzzzzzzzzzzz*");
  })
});

// B provides an "around" method
var B = dcl(A, {
  declaredClass: "B",
  sleep: function(){
    console.log("Time to hit the pillow!");
  }
});

var george = new B();
// we add to the variable one more "after" advise
advise.after(george, "sleep", function(){
  console.log("*ZzZzZzZzZzZzZ*")
});

dclDebug.log(george);
{% endcodeblock %}

The snippet above will produce a following output on console:

{% codeblock %}
*** object of class B
*** class B depends on 1 classes
    dependencies: A
    class method constructor is CHAINED AFTER (length: 0)
    class method sleep is UNCHAINED BUT CONTAINS ADVICE(S),
      and has an AOP stub (before: 0, around: 1, after: 1)
    object method sleep has an AOP stub (before: 0, around: 1, after: 2)
{% endcodeblock %}

## Notes

1. It is always a good idea to specify a property called `declaredClass`,
which can be any readable text used to identify your "class" definition.
It is used by `dclDebug` facilities to provide a human-readable information.
Common convention is to specify a name to reflect its logical "path", like
"dcl/debug" or "dcl/debug/CycleError".
