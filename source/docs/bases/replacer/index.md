---
layout: page
title: "Replacer"
date: 2012-07-29 13:55
comments: false
sharing: true
footer: true
---

`Replacer` is a simple base class, which is very similar to [Mixer](/docs/bases/mixer).
The difference is that it is used to override only existing properties, it doesn't
add new properties to instance.

It can be included with following commands:

{% codeblock Include Replacer lang:js %}
// node.js
var Replacer = require("dcl/bases/Replacer");
...

// AMD (code)
require(["dcl/bases/Replacer"], function(Replacer){
  ...
});

// AMD (definition)
define(["dcl/bases/Replacer"], function(Replacer){
  ...
});
{% endcodeblock %}

## Description

Here is its definition:

{% codeblock Replacer lang:js %}
var Replacer = dcl(null, {
  declaredClass: "dcl/bases/Replacer",
  constructor: function(x){
    var empty = {};
    for(var name in x){
      if(name in this){
        var t = x[name], e = empty[name];
        if(t !== e){
          this[name] = t;
        }
      }
    }
  }
});
{% endcodeblock %}

As you can see it overrides existing properties with non-default values.
All other properties are ignored. It is a "tame" version of [Mixer](/docs/bases/mixer),
which can be used to keep instances clean of unwanted properties.
`Replacer` can be used as a base, or as a mixin, but usually it serves as
the most deepest base to take care of parameters.

Refer to [Best practices for constructors](/docs/general/constructors)
for discussion on constructor' signatures.

## Examples

{% codeblock Mixer example lang:js %}
var Person = dcl(Replacer, {
  declaredClass: "Person",
  firstName:  "",
  middleName: "",
  lastName:   ""
  constructor: function(){
    // no need to deal with parameters - they are already copied
    // on this instance by Mixer
    console.log("Hello " + this.firstName);
  },
  getFullName: function(){
    var name = [];
    if(this.firstName){
      name.push(this.firstName);
    }
    if(this.middleName){
      name.push(this.middleName);
    }
    if(this.lastName){
      name.push(this.lastName);
    }
    return name.join(" ");
  }
});

var bob = new Person({
  firstName:   "Robert",
  lastName:    "Smith",
  dateOfBirth: new Date(1985, 11, 31),
  shortName:   "Bob",
  getFullName: function(){
    return "Robert 'Bob' Smith";
  }
});

console.log(bob.getFullName()); // Robert 'Bob' Smith
console.log(bob.firstName);     // Robert
console.log(bob.shortName);     // unknown
{% endcodeblock %}
