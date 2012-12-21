---
layout: page
title: "Intro"
date: 2012-12-17 01:16
comments: false
sharing: true
footer: true
---

`dcl` is a minimalistic yet complete JavaScript package for
[node.js](http://nodejs.org) and modern browsers. It implements OOP
with mixins + AOP at both "class" and object level, and works in strict 
and non-strict modes.

The simplest way to learn something is to dive right in. Let's implement a simple
widget based on reactive templating: when we change parameters of a widget, they
are immeditely reflected in a web page.

Assuming that we run our code using AMD format in browser, our "code shell"
will look like that:

```js
require(
  "dcl", "dcl/bases/Mixer", "dcl/mixins/Cleanup", "dcl/advices/memoize"
  function(dcl, Mixer, Cleanup, memoize){
    // our code goes here
  }
);
```

As the first step let's code our data model:

```js
var Data = dcl(Mixer, {
  declaredClass: "Data",
  updateData: function(data){
    dcl.mix(this, data);
  }
});
```

We derived our class using single inheritance from
[Mixer](http://www.dcljs.org/docs/bases/mixer/), which comes with `dcl`.
`Mixer` is a very simple base. All it does is it copies properties of
the first constructor argument to an instance.

Obviously in this simple example we could just call `updateData()` from our
constructor, but let's assume that a constructor and an updater can do
(slightly) different things and we want to keep them separately.

`declaredClass` is completely optional, yet recommended to be specified
(any unique human-readable name is fine), because it is used by debugging
helpers included with `dcl`.

Now let's code our nano-sized template engine, which substitutes strings
like this: "${abc}" with properties taken directly from an instance
(`this.abc` in this case). Something like that:

```js
var Template = dcl(null, {
  declaredClass: "Template",
  render: function(templateName){
    var self = this;
    return this[templateName].replace(/\$\{([^\}]+)\}/g, function(_, prop){
      return self[prop];
    });
  }
});
```

We specify what template to use by name, which is a property name on
an object instance, and it fills out a template string using properties
specified on an object.

This is another demonstration of single inheritance: our `Template` is based
on a plain vanilla `Object`, like any JavaScript's object, which is indicated
by using `null` as a base.

What else do we need? We need a way to manage our DOM node:

```js
var Node = dcl([Mixer, Cleanup], {
  show: function(text){
    if(this.node){
      this.node.innerHTML = text;
    }
  },
  destroy: function(){
    if(this.node){
      this.node.innerHTML = "";
    }
  }
});
```

The code above provides a way to show some HTML, and clears out its presentation
when we `destroy()` a widget.

It uses two bases: already mentioned `Mixer` is used to get a property in
during initialization (`node` in this case), and
[Cleanup](http://www.dcljs.org/docs/mixins/cleanup/), which again comes with `dcl`.
The latter chains all `destroy()` methods together and provides a simple
foundation for clean up management, so all resources can be properly disposed of.

What we did up to this point is we came up with very small manageable orthogonal
components, which reflect different sides of our widget, and can be combined
together in different configurations. Let's put them all together now:


```js
var NameWidget0 = dcl([Data, Template, Node], {
  declaredClass: "NameWidget0",
  template: "Hello, ${firstName} ${lastName}!"
});

var x = new NameWidget0({
  node:      document.getElementById("name"),
  firstName: "Bob",
  lastName:  "Smith"
});

x.show(x.render("template")); // Hello, Bob Smith!
x.updateData({firstName: "Jill"});
x.show(x.render("template")); // Hello, Jill Smith!
```

It works, but it is not very coherent, and way too verbose. Don't worry,
we will fix it soon.

Some readers probably noticed that we have three bases now: `Data`, `Template`,
and `Node`, and two of them (`Data`, and `Node`) are based on `Mixer`.
How does it work? It works fine, because underneath `dcl` uses
[C3 superclass linearization algorithm](http://en.wikipedia.org/wiki/C3_linearization)
(the same one used by Python), which removes duplicates, and sorts bases
to ensure that their requested order is correct. In this case a single
copy of `Mixin` should go before both `Data` and `Node`. Read more on
that topic in [dcl() documentation](http://www.dcljs.org/docs/mini_js/dcl/).

Now let's address deficiencies of our implementation #0:

* As soon as a widget is constructed, we should show text.
* As soon as data is updated, we should show text.

Both requirements are simple and seem to call for good old-fashioned supercalls:

```js
var NameWidget1 = dcl([Data, Template, Node], {
  declaredClass: "NameWidget1",
  template: "Hello, ${firstName} ${lastName}!",
  constructor: function(){
    this.showData();
  },
  updateData: dcl.superCall(function(sup){
    return function(){
      sup.apply(this, arguments);
      this.showData();
    };
  }),
  showData: function(){
    var text = this.render("template");
    this.show(text);
  }
});

var x = new NameWidget1({
  node:      document.getElementById("name"),
  firstName: "Bob",
  lastName:  "Smith"
});
// Hello, Bob Smith!

x.updateData({firstName: "Jill"}); // Hello, Jill Smith!
```

Much better!

Let's take a look at two new things: constructor and a supercall. Both
are supposed to be supercalls, yet look differently. For example,
constructor doesn't call its super method. Why? Because `dcl` chains
constructors automatically.

`updateData()` is straightforward: it calls a super first, then a method
to update a visual. But it is declared using a double function pattern.
Why? For two reasons: run-time efficience, and ease of debugging. Read all
about it in [dcl.superCall() documentation](http://www.dcljs.org/docs/mini_js/supercall/),
and [Supercalls in JS](http://www.dcljs.org/docs/general/supercalls/).

While this implementation looks fine, it is far from "fine". Let's be smart
and look forward: in real life our implementation will be modified and
augmented by generations of developers. Some will try to build on top of it.

* Our call to `showData()` in construct is not going to be the last code
  executed, as we expected. Constructors of derived classes will be called
  after it.
* `updateData()` will be overwritten, and some programmers may forget
  to call a super. Again, they may update data in their code after
  our code called `showData()` resulting in stale data shown.

Obviously we can write lengthy comments documenting our "implementation decisions",
and suggesting future programmers ways to do it right, but who reads docs and
comments especially when writing "industrial" code in a crunch time?

It would be nice to solve those problems in a clean elegant way. Is it even possible?
Of course. That's why we have AOP.

Let's rewrite our attempt #1:

```js
var NameWidget2 = dcl([Data, Template, Node], {
  declaredClass: "NameWidget2",
  template: "Hello, ${firstName} ${lastName}!",
  constructor: dcl.after(function(){
    this.showData();
  }),
  updateData: dcl.after(function(){
    this.showData();
  }),
  showData: function(){
    var text = this.render("template");
    this.show(text);
  }
});

var x = new NameWidget2({
  node:      document.getElementById("name"),
  firstName: "Bob",
  lastName:  "Smith"
});
// Hello, Bob Smith!

x.updateData({firstName: "Jill"}); // Hello, Jill Smith!
```

Not only we got a (slightly) smaller code, now we are guaranteed, that
`showData()` is called after all possible constructors, and after every
invokation of `updateData()`, which can be completely replaced with code
that may use supercalls. We don't really care --- we just specified
code, which will be executed *after* whatever was put there by other
programmers.

Now imagine that our user wants to click on a name, and get a pop-up with
more detailed information, e.g., an HR record of that person. It would make
sense to keep the information in one place, yet render it differently.
And we already have a provision for that: we can add another template
property, and call `render()` with its name:

```js
var PersonWidget1 = dcl(NameWidget2, {
  declaredClass: "PersonWidget1",
  detailedTemplate: "..."
});

var x = new PersonWidget1({
  node:      document.getElementById("name"),
  firstName: "Bob",
  lastName:  "Smith",
  position:  "Programmer",
  hired:     new Date(2012, 0, 1) // 1/1/2012
});
// Hello, Bob Smith!

var detailed = x.render("detailedTemplate");
```

In the example above I skipped the definition of a detailed template
for brevity. But you can see that we can add more information about 
person, and we can define different templates when a need arises.

Imagine that we profiled our new implementation and it turned out
that we call `render()` method directly and indirectly very frequently,
and it introduces some measurable delays. We can pre-render a template
eagerly on every data update, yet it sounds like a lot of work for several
complex templates, and some of them are not even going to be used. Better
solution is to implement some kind of lazy caching: we will invalidate cache
on every update, yet we will build a string only when requested.

Obviously such changes involve both `Data` and `Template`. Or it can be done
downstream in `NameWidget` or `PersonWidget`. Now look above and please
refrain from doing those changes: so far we tried to keep our "classes"
orthogonal, and caching is clearly an orthogonal business.

`dcl` already provides a simple solution:
[memoize advice](http://www.dcljs.org/docs/advices/memoize/).
Let's use it in our example:

```js
var PersonWidget2 = dcl(NameWidget2, {
  declaredClass: "PersonWidget2",
  detailedTemplate: "...",
  // memoization section:
  render:     dcl.advise(memoize.advice("render")),
  updateData: dcl.advise(memoize.guard ("render"))
});
```

With these two lines added our `render()` result is cached for every
first parameter value ("template" or "detailedTemplate" in our case),
and the cache will be invalidated every time we call `updateData()`.

## Summary

In this article we presented `dcl` package. If you plan to use it
in your [node.js][] project install it like this:

```
npm install dcl
```

For your browser-based projects I suggest to use [volo.js](http://volojs.org):

```
volo install uhop/dcl
```

The code is an open source on [github.com/uhop/dcl](https://github.com/uhop/dcl)
under New BSD and AFL v2 licenses.

This article didn't cover a lot of other things provided by `dcl`:

* Avoid the double function pattern in your legacy projects using `inherited()`
  supercalls.
* Use AOP on object-level --- add and remove advices dynamically in any order.
* Specify "before" and "after" automatic chaining for any method.
* Use debug helpers that come with `dcl`.
* Leverage a small library of canned advices and mixins provided by `dcl`.

If you want to learn more about it, or just curious, you can find a lot of
information in [the documentation](http://www.dcljs.org/docs/).

Happy [DRY](http://en.wikipedia.org/wiki/Don%27t_repeat_yourself) coding!
