---
layout: page
title: "dcl.advise()"
date: 2012-07-29 00:06
comments: false
sharing: true
footer: true
---

This is a decorator, which is used to weave AOP advices while building new "classes".

## Description

`dcl.advise()` is a decorator function, which takes an object with properties `before`, `around`, and/or `after` and
combines an existing method with supplied advices.

{% codeblock dcl.advise() lang:js %}
var A = dcl(null, {
  method: function(msg){
    console.log("MSG: " + msg);
  }
});

var B = dcl(A, {
  method: dcl.advise({
    before: function(msg){
      console.log("Method was called with msg = " + msg);
    },
    after: function(args, result){
      console.log("Method has finished.");
    },
    around: function(sup){
      return function(msg){
        // let's ignore our parameter
        sub.call(this, "Canned response no matter what.");
      };
    }
  })
});

var b = new B();
b.method("Hey!");
// Method was called with msg = Hey!
// MSG: Canned response no matter what.
// Method has finished.
{% endcodeblock %}

Advices are functions with following properties.

### Before

This is a regular function. It is called with the same context and the same arguments as an advised method.
Its return value is ignored.

It is not recommended to modify parameters inside `before` advice. Use `around` advice for that.

### After

This is a regular function. It is called with the same context as an advised method. It takes two parameters: `args` is
an `arguments` object (a pseudo-array) used to call an advised method, and `result`, which is a returned value or
a thrown exception object. Its returned value is ignored.

It is not recommended to modify parameters or a returned value inside `after` advice. Use `around` advice for that.

It is recommended to derive all exception objects from the standard `Error` object, so erroneous and normal
result values would be distinct.

### Around

Essentially it is the same as [dcl.superCall()](/docs/mini_js/supercall). It uses the same double function pattern,
and its behavior is the same.

### Order of advices

Advices are always applied in the following order regardless of their declaration order:

1. All `before` advices go first in the reverse chronological order (the last one goes first).
2. All `around` advices go next in the reverse chronological order (the last one goes first). The next `around` advice
is called only if its previous `around` advice yielded control explicitly by calling its super method.
3. All `after` advices go last in the chronological order (the first one goes first).

## Notes

### Shortcuts

If you want to weave just one advice, you may want to use a shortcut:

{% codeblock AOP shortcuts lang:js %}
var B1 = dcl(A, {
  method: dcl.before(function(msg){
    console.log("Method was called with msg = " + msg);
  })
});
// is equivalent to
var B2 = dcl(A, {
  method: dcl.advise({
    before: function(msg){
      console.log("Method was called with msg = " + msg);
    }
  })
});

var B3 = dcl(A, {
  method: dcl.after(function(args, result){
    console.log("Method has finished.");
  })
});
// is equivalent to
var B4 = dcl(A, {
  method: dcl.advise({
    after: function(args, result){
      console.log("Method has finished.");
    }
  })
});

var B5 = dcl(A, {
  method: dcl.around(function(sup){
    return function(msg){
      // let's ignore our parameter
      sub.call(this, "Canned response no matter what.");
    };
  })
});
// is equivalent to
var B6 = dcl(A, {
  method: dcl.advise({
    around: function(sup){
      return function(msg){
        // let's ignore our parameter
        sub.call(this, "Canned response no matter what.");
      };
    }
  })
});
{% endcodeblock %}

You can find those methods documented respectively in [dcl.before()](/docs/dcl_js/before),
[dcl.after()](/docs/dcl_js/after), and [dcl.around()](/docs/dcl_js/around).

### More on order of advices

The described order is followed to the letter. Specifically I want to stress "regardless of their declaration order".
It doesn't matter in what order advices were declared.

Which is not true for simple faux-AOP wrapper-based implementations. To wit:

{% codeblock Wrapper-based faux-AOP lang:js %}
// UBER-SIMPLE FAUX-AOP

function wrapBefore(object, name, advice){
  var sup = object[name];
  object[name] = function(){
    advice.apply(this, arguments);
    return sub.apply(this, arguments);
  };
}

function wrapAfter(object, name, advice){
  var sup = object[name];
  object[name] = function(){
    try{
      var result = sub.apply(this, arguments);
      advice.call(this, arguments, result);
    }
    catch(e){
      advice.call(this, arguments, e);
    }
    return result;
  };
}

function wrapAround(object, name, advice){
  var sup = object[name];
  object[name] = function(){
    // for simplicity I assume that the advice takes
    // its super as its first parameter, and all arguments
    // as the second parameter
    advice.call(this, sup, arguments);
  };
}

// EXAMPLE

var x = {a: function(){ console.log("HA!"); }};

wrapBefore(x, "a", function(){ console.log("before"); });
wrapAround(x, "a", function(sup){
  console.log("around: before calling");
  sup.apply(this, arguments);
  console.log("around: after calling");
});
wrapAfter(x, "a", function(){ console.log("after"); });

// RESULT:
// around: before calling
// before
// HA!
// around: after calling
// after

// SHOULD BE:
// before
// around: before calling
// HA!
// around: after calling
// after
{% endcodeblock %}

In general the relative order of different wrapper-based advices will depend on their definition order,
while in true AOP it is rigid.

While the order difference looks harmless, it prevents from using some important AOP techniques. For example,
it prevents setting up a hook function (an after advice) that runs after all "normal" methods.
See [multi-stage construction](/docs/general/multi-stage-construction) for an interesting use case.
