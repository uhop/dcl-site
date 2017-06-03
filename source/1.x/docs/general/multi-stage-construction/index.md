---
layout: page
title: "Multi-stage construction"
date: 2012-07-29 01:23
comments: false
sharing: true
footer: true
---

*Version 1.x*

In some cases it would be beneficial to run some code after all constructors,
but before an object is ready for use. Some valid examples:

* Deleting objects and freeing resources, which were required for initialization,
but have no use after that.
* Creating new objects and allocating new resources, which depend on combined work
of other constructors.

The problem here is that with mixins we have no idea when constructors stop running: after
any given constructor another one can be weaved.

Let's illustrate it with a simple example: templating. Imagine that our object has
a template, which should be populated by properties on an instance. Those properties
are added by constructors. So let's create a mixin for that:

```js Template
var Template = dcl(null, {
  declaredClass: "Template",
  template: "Hello, ${fullName}!", // our template string
  populateTemplate: function(){
    var self = this;
    this.text = template.replace(/\$\{([^\}]+)\}/g, function(_, prop){
      return self[prop];
    })
  }
});
```
Looks perfect: simple yet flexible. If `fullName` is "Robert Smith", following
result will be created:

{% codeblock %}
Hello, Robert Smith!
{% endcodeblock %}

The only question is when to call it.

## Solution #1 (fail)

Let's call it from our constructor:

```js Solution #1 (fail)
var Template = dcl(null, {
  ...
  constructor: function(){
    this.populateTemplate();
  },
  ...
});
```

While it looks okay, it will fail: a template may contain calculated properties (e.g.,
`fullName` can be a combination of `firstName` and `lastName`), and there is no guarantee
that their values are calculated in constructors that run before our `Template`. Chances
are we will look at "Hello, undefined!".

## Solution #2 (epic fail!)

Let's be uber-smart and call the method using `setTimeout()`:

```js Solution #2 (epic fail!)
// NEVER DO THAT!!!
var Template = dcl(null, {
  ...
  constructor: function(){
    var self = this;
    setTimeout(function(){
      self.populateTemplate();
    }, 0);
  },
  ...
});
```

The thinking goes like that:

> Constructors run and at some point they all finish. So if we schedule our call
> for a next time slice, we are guaranteed to run after all constructors.

> What time slice? JavaScript systems are usually event-driven and
> as such operate asynchronously responding to external events.

> Next time slice? I set a timer for 0ms, so my code will be called immediately
> without any wait.

Unfortunately this thinking, while prevalent, fails on several accounts:

* "0ms timeout" is not free, and not exactly equals to "next time slice". Read all
about it in
[More on 0ms timeouts](http://lazutkin.com/blog/2012/jul/28/more-on-0ms-timeouts/).
* What if as soon as we constructed an object we started to use it without waiting
for time slices? Making this condition part of a contract (e.g., by documenting it)
makes use of such objects cumbersome.
  * This problem is present even if we use something like [nextTick()](http://nodejs.org/docs/v0.4.7/api/process.html#process.nextTick) of [node.js](http://nodejs.org)
  instead of `setTimeout()`.

## Solution #3 (just works)

Use AOP. Schedule to run the method using "after" advice:

```js Solution #3 (just works)
var Template = dcl(null, {
  ...
  constructor: dcl.after(function(){
    this.populateTemplate();
  }),
  ...
});
```

This way it is guaranteed that it will run *after* all other constructors, and
without any delay. `Template` can be mixed in any order with other mixins, yet
its code will always run after "proper" constructors.

## Summary

Never underestimate the power of AOP techniques. They are here to make programmer's life
easier. That's why `dcl` supports both dynamic (object-level) and static (class-level)
AOP advices.

Just like with an "after" advice, it is possible to prepare for construction with
"before" advices, or use similar techniques with regular methods. Frequently an AOP
solution is much more elegant and robust than alternative hacks.
