---
layout: page
title: "Mixer"
date: 2017-06-08 13:55
comments: false
sharing: true
footer: true
---

*Version 2.x*

`Mixer` is a simple base class that mixes properties from its only argument directly on its instance. It can be used to add new properties, or override existing properties on an instance including methods. `Mixer` is very simple yet extremely powerful, when used correctly.

It is defined in `dcl/bases/Mixer.js`.

## Description

Here is its definition:

{% codeblock Mixer lang:js %}
var Mixer = dcl(null, {
	declaredClass: "dcl/bases/Mixer",
	constructor: function (x) {
    Object.defineProperties(this,
      dcl.collectPropertyDescriptors({}, x));
	}
});
{% endcodeblock %}

As you can see that in a nutshell it is a one-liner that uses
[dcl.collectPropertyDescriptors()](/2.x/docs/dcl_js/collectpropertydescriptors/) to do the work. `Mixer` can be used as a base, or as a mixin, but usually it serves as the most deepest base to take care of parameters.

Refer to [Best practices for constructors](/2.x/docs/general/constructors/) for discussion on constructor' signatures.

## Examples

{% codeblock Mixer example lang:js %}
var Person = dcl(Mixer, {
  declaredClass: "Person",
  firstName:  "",
  middleName: "",
  lastName:   ""
  constructor: function () {
    // no need to deal with parameters - they are already copied
    // on this instance by Mixer
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
  getAge: function(){
    var today = new Date();
    // not really, just an estimate
    return today.getFullYear() -
      this.dateOfBirth.getFullYear();
  }
});

console.log(bob.getFullName() + " is " + bob.getAge());
{% endcodeblock %}
