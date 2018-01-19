---
layout: post
title: "dcl6 is coming"
date: 2018-01-18 20:00:50 -0600
comments: true
categories: announce
---

New version of `dcl` is coming: `dcl6`. This is an experimental version written from the ground up specifically to take advantage of new ES6 language features: new `class` keyword, new `super` mechanism. The implementation uses symbols to keep innards truly private.

The principal coding has been finished several months ago, and the new library was under extensive real-world testing. Missing features: `debug` module is unfinished, and the documentation is in early stages. So right now it is only for brave developers, who feel comfortable reading tests and the code to understand the changed API, and who are not afraid to encounter possible bugs.

Logically, it is based on [dcl 2.x](/2.x/docs/) branch and supports all advanced ES5 features as well. Of course, it supports chaining and AOP advices we all come to love. It even provides the same set of advices, mixins, and utilities. As before, it has no external dependencies, and minimal in size.

<!-- more -->

So how does it look?

Example: ES6 features with tracing advices.

{% codeblock Tracing advices lang:js %}
const fn1 = (...args) => { console.log('BEFORE', args); };
const fn2 = (args, result) => { console.log('AFTER', args, '=', result); };

const A = dcl(null, M, Base => class extends Base {
  static get [dcl.declaredClass]() { return 'A'; }

  constructor() {
    super();
    this.__name = 'Bob';
  }

  get name()  { return this.__name; }
  set name(n) { this.__name = n; }

  method(x) {
    return x + super.method(x);
  }

  static get [dcl.directives]() {
    return {
      method: {
        before: fn1,
        after:  fn2
      },
      name: {
        get: {
          before: fn1,
          after:  fn2
        },
        set: {
          before: fn1,
          after:  fn2
        }
      }
    };
  }
});
{% endcodeblock %}

Example: inherit built-in classes. (Yes, we finally can do that in ES6! And they do behave properly, down to "magic" properties!)

{% codeblock Inherit built-in classes lang:js %}
const SuperArray = dcl(Array, Base => class extends Base {
  static get [dcl.declaredClass]() { return 'SuperArray'; }
  top() { return this[this.length - 1]; }
  pop() { console.log('*pop*'); return super.pop(); }
});
{% endcodeblock %}


Example: chaining directives.

{% codeblock Chaining lang:js %}
const Destroyable = Base => class extends Base {
  static get [dcl.declaredClass]() { return 'Destroyable'; }
  static get [dcl.directives]() {
    return {
      destroy: {
        chainWith: 'chainBefore',
        before: () => { console.log('destroy before: Destroyable'); },
        after:  () => { console.log('destroy after: Destroyable'); }
      }
    };
  }

  destroy() { console.log('destroy: Destroyable'); }
};

const A = dcl(null, Destroyable, Base => class extends Base {
  static get [dcl.declaredClass]() { return 'A'; }
  static get [dcl.directives]() {
    return {
      destroy: {
        chainWith: 'chainBefore',
        before: () => { console.log('destroy before: A'); },
        after:  () => { console.log('destroy after: A'); }
      }
    };
  }

  destroy() { console.log('destroy: A'); }
});
{% endcodeblock %}

Example: post-construction.

{% codeblock Post-construction lang:js %}
const PostConstructed = Base => class extends Base {
  static get [dcl.declaredClass]() { return 'PostConstructed'; }
  static get [dcl.directives]() {
    return {
      constructor: {
        after: args => { console.log('post construction:', args); }
      }
    };
  }

  constructor() {
    super();
    console.log('ctr: PostConstructed');
  }
};

const A = dcl(null, PostConstructed, Base => class extends Base {
  static get [dcl.declaredClass]() { return 'A'; }

  constructor() {
    super();
    console.log('ctr: A');
  }
});
{% endcodeblock %}

`dcl6` is being hosted in a separate repository: https://github.com/uhop/dcl6 At the moment it is not on `npm`, so the only way to play with it is to clone the repo.
