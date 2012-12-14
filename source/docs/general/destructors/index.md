---
layout: page
title: "Destructors"
date: 2012-07-29 01:16
comments: false
sharing: true
footer: true
---

*(This page is a reworked excerpt from [OOP and JS](http://lazutkin.com/blog/2012/jan/18/oop-and-js/).)*

There is a lot of confusion about [destructors][] in JavaScript and garbage-collected languages in general. The main idea is to have a counterpart to a constructor, which will "destroy" an object. Why do we need it? It should ensure that all resources allocated to an object are properly disposed of: memory is freed, files are closed, network sockets are released, event sources are unsubscribed for, and so on.

Modern languages are usually garbage collected, so we don't need to worry about memory per se in most cases, but other resources are still there and should be dealt with appropriately. Java has it in a form of [finalizers](http://en.wikipedia.org/wiki/Finalizer).

One misconception about destructors is that many programmers think that in our garbage-collected world only physical resources (files, network, USB devices, and so on) should be released. Unfortunately it is not so.

There are several categories of resources, which are pure memory, yet should be taken care of. Examples:

* Some objects insert themselves in lists/structures kept by other objects. Imagine that you don't need your object anymore, yet its included an a long-lived list -- your object will not be garbage-collected until that list dies. If your object did some event processing with events coming from that list, it will continue to do so consuming resources and potentially breaking your program.
* Some objects employ buffering techniques to accumulate data before passing it to physical objects (files, network sockets), or memory-based entities. Garbage-collecting such object without flushing a buffer may lead to data corruption.

"But JS doesn't have a concept of finalizer/destructor?" True. With garbage-collected languages the moment of collection is not well defined, so in many cases we cannot rely on a finalizer -- we have to do it manually. Imagine that we "lost" a file object relying on the fact that its finalizer closes the file, and it does, but 2 days later. Not what we expected. So in many cases we have to call such finalizer manually.

Just like constructors destructors should be chained but in a reverse order -- the only way to preserve object invariants. Again, JS doesn't help here (ditto Java with its finalizers), and we have to chain inherited finalizers manually. Obviously this process is error-prone, yet stupidly simple, and can be easily automated.

With `dcl` you can always chain your life-cycle methods with [dcl.chainBefore()](/docs/dcl_js/chainbefore) for destructor-like methods and [dcl.chainAfter()](/docs/dcl_js/chainafter) for constructor-like methods.

Additionally `dcl` offers two library components: mixins
[Destroyable](/docs/mixins/destroyable) to automatically chain `destroy()` method,
and [Cleanup](/docs/mixins/cleanup), which leverages
[Destroyable](/docs/mixins/destroyable) to provide a foundation for an elaborate
integrated life-cycle management.

## Note on specialized cleanup methods

What if I already have a method to do a cleanup? For example, in my file object I have `close()` method. Is it OK to have both? Do I need to call `close()` or a destructor (whatever it is called in your system)?

I would say that both can be present, but personally I would expect that after `close()` I can still use the object, e.g., call `open()` on it, while after calling a destructor that object is as good as dead.

Nevertheless one can be an alias for another, e.g, `destroy()` can (and should) call `close()`.

Having a common destructor (e.g., a method named `destroy()`) helps people -- no need to remember object-specific verbs. It helps to create a reusable components like various containers, which may destroy its content when required without going into details about contained objects.

## Summary

Always evaluate if your objects need an explicit destruction. Provide a unified method
to do that. Leverage helpers provided by `dcl`.

[destructors]:   http://en.wikipedia.org/wiki/Destructor_(computer_programming)
