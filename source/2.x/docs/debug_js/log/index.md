---
layout: page
title: "dcl.log()"
date: 2017-06-09 00:12
comments: false
sharing: true
footer: true
---

*Version 2.x*

The main method of this module logs on console debugging details about an object. Provided details includes an ordered list of dependencies, super calls, and both class-level and object-level AOP advises.

## Description

Working with non-trivial inheritance chains can be puzzling. While the C3 MRO algorithm used by `dcl` takes care of duplicates and ordering of mixins, in some cases programmer needs to know the exact details of such linearization.

Even more puzzling can be ordering of call chains and/or advices, both static and dynamic.

`dcl.log()` provides both types of information, and inspects what constructor was used to create an object.

## Examples

{% codeblock dcl.log() lang:js %}
var dcl    = require("dcl/debug"),
	advise   = require("dcl/advise");

// A defines an "after" advise
var A = dcl(null, {
  declaredClass: "A",
  sleep: dcl.after(function () {
    console.log("*zzzzzzzzzzzzz*");
  })
});

// B provides an "around" method
var B = dcl(A, {
  declaredClass: "B",
  sleep: function () {
    console.log("Time to hit the pillow!");
  }
});

var george = new B();
// we add to the variable one more "after" advise
advise.after(george, "sleep", function(){
  console.log("*ZzZzZzZzZzZzZ*")
});

dcl.log(george);
{% endcodeblock %}

The snippet above will produce a following output on console:

{% codeblock lang:text %}
*** object of class B
*** class B depends on 1 class: A
*** class B has 2 weavers: constructor: after, sleep: super
    sleep: object-level advice (before 0, after 2)
{% endcodeblock %}

## Notes

It is always a good idea to specify a property called `declaredClass`, which can be any readable text used to identify your "class" definition. It is used by `dcl/debug` facilities to provide a human-readable information. Common convention is to specify a name to reflect its logical "path", like `"dcl/debug"` or `"dcl/bases/Mixer"`.
