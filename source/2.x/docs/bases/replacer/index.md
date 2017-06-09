---
layout: page
title: "Replacer"
date: 2017-06-08 13:55
comments: false
sharing: true
footer: true
---

*Version 2.x*

`Replacer` is a simple base class, which is very similar to [Mixer](mixer). The difference is that it is used to override only existing properties, it doesn't add new properties to instance.

It is defined in `dcl/bases/Replacer.js`.

## Description

Here is its definition:

{% codeblock Replacer lang:js %}
var Replacer = dcl(null, {
  declaredClass: "dcl/bases/Replacer",
  constructor: function (x) {
    var props = dcl.collectPropertyDescriptors({}, x);
    Object.keys(props).forEach(function (name) {
      if (name in this) {
        Object.defineProperty(this, name, props[name]);
      }
    }, this);
  }
});
{% endcodeblock %}

As you can see it overrides existing properties with non-default values. All other properties are ignored. It is a "tame" version of [Mixer](mixer), which can be used to keep instances clean of unwanted properties. `Replacer` can be used as a base, or as a mixin, but usually it serves as the most deepest base to take care of parameters.

Refer to [Best practices for constructors](../general/constructors) for discussion on constructor' signatures.

## Examples

{% codeblock Mixer example lang:js %}
var Person = dcl(Replacer, {
  declaredClass: "Person",
  
  firstName:  "",
  middleName: "",
  lastName:   "",
  
  constructor: function () {
    // no need to deal with parameters - they are already copied
    // on this instance by Replacer
    console.log("Hello " + this.firstName);
  },
  
  getFullName: function () {
    var name = [];
    if (this.firstName) {
      name.push(this.firstName);
    }
    if (this.middleName) {
      name.push(this.middleName);
    }
    if (this.lastName) {
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
  getFullName: function () {
    return "Robert 'Bob' Smith";
  }
});

console.log(bob.getFullName()); // Robert 'Bob' Smith
console.log(bob.firstName);     // Robert
console.log(bob.shortName);     // undefined
{% endcodeblock %}
