---
layout: page
title: "dcl.advise()"
date: 2017-06-04 00:06
comments: false
sharing: true
footer: true
---

*Version 2.x*

This is a decorator, which is used to weave AOP advices while building new "classes".

## Description

`dcl.advise()` is a decorator function, which takes the advice object with properties `before`, `around`, and/or `after` and
combines an existing method with supplied advices.

Alternatively it can take [dcl.Prop](/2.x/docs/dcl_js/prop/) object, and advise its `get`, `set`, or `value` properties. For more info on property descriptors see [Object.defineProperties()](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperties).

{% codeblock dcl.advise() lang:js %}
var A = dcl({
  method: function (msg) {
    console.log("MSG: " + msg);
  }
});

var B = dcl(A, {
  method: dcl.advise({
    before: function (msg) {
      console.log("Method was called with msg = " + msg);
    },
    after: function (args, result) {
      console.log("Method has finished.");
    },
    around: function (sup) {
      return function (msg) {
        // let's ignore our parameter
        sup.call(this, "Canned response no matter what.");
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

{% codeblock dcl.advise() with dcl.prop() lang:js %}
var A = dcl({
  constructor: function (msg) { this.msg = msg; },
  m: dcl.prop({
      get: function () {
        return "MSG: " + this.msg;
      }
    })
});

var B = dcl(A, {
  m: dcl.prop({
      get: dcl.advise({
        before: function () {
          console.log("msg = " + this.msg);
        },
        after: function (args, result) {
          console.log("Getter has finished.");
        },
        around: function(sup){
          return function(msg){
            // let's ignore our parameter
            return sup.call(this) + " vey!";
          };
        }
      })
    })
});

var b = new B("Oy");
console.log(b.m);
// msg = Oy
// Getter has finished.
// MSG: Oy vey!
{% endcodeblock %}

Advices are functions with following properties.

### Before

This is a regular function. It is called with the same context and the same arguments as an advised method.
Its return value is ignored.

It is not recommended to modify parameters inside `before` advice. Use `around` advice for that.

### After

This is a regular function. It is called with the same context as an advised method. It takes up to four parameters:

* `args` - an `arguments` object (a pseudo-array) used to call an advised method.
* `result` - a returned value or a thrown exception object.
* `makeReturn(value)` - a procedure, which can be called to supply a new returned value.
* `makeThrow(value)` - a procedure, which can be called to emulate an exception. In this case `value` is assumed to be a valid exception value, e.g., an `Error` object.

Both `makeReturn()` and `makeThrow()` can be called several times. The last value is used as the result.

The returned value of an after advice is ignored.

It is not recommended to modify parameters or a returned value inside `after` advice. Use `makeReturn()`, or `makeThrow()` for that. Or consider using `around` advice.

It is recommended to derive all exception objects from the standard `Error` object, so erroneous and normal
result values would be easily distinguished.

### Around

Essentially it is the same as [dcl.superCall()](/2.x/docs/dcl_js/supercall/). It uses the same double function pattern,
and its behavior is the same.

### Order of advices

Advices are always applied in the following order regardless of their declaration order:

1. All `before` advices go first in the reverse chronological order (the last one goes first).
2. All `around` advices go next in the reverse chronological order (the last one goes first). The next `around` advice
is called only if its previous `around` advice yielded control explicitly by calling its super method.
3. All `after` advices go last in the chronological order (the first one goes first).

Both `before` and `after` chains are called regardless how `around` advices are handled. For example, this is a totally valid situation:

{% codeblock Before and after chains lang:js %}
var A = dcl({
  m: dcl.advise({
      before: function () {
        console.log("A.m() before");
      },
      after: function (args, result) {
        console.log("A.m() after - " + result);
      },
      around: function (sup) {
        return function () {
          console.log("A.m() around");
          return 0;
        }
      }
    })
});

var a = new A();
console.log(a.m());
// A.m() before
// A.m() around
// A.m() after - 0
// 0

var B = dcl(A, {
  m: dcl.advise({
      before: function () {
        console.log("B.m() before");
      },
      after: function (args, result) {
        console.log("B.m() after - " + result);
      },
      around: function (sup) {
        return function () {
          console.log("B.m() around");
          return 42;
        }
      }
    })
});

var b = new B();
console.log(b.m());
// B.m() before
// A.m() before
// B.m() around
// A.m() after - 42
// B.m() after - 42
// 42
{% endcodeblock %}

As you can see it is not necessary to call a super in `around` advices &mdash; `before` and `after` chains will be called regardless.

## Examples

{% codeblock dcl.advise() changes return values lang:js %}
var A = dcl({
    m: function (x) { return x; }
  });
  
var a = new A();
console.log(a.m(5)); // 5
console.log(a.m(6)); // 6

var B = dcl(A, {
    m: dcl.advise({
        after: function (args, result, makeReturn, makeThrow) {
          if (result % 2) {
            makeReturn(1);
            return;
          }
          makeThrow(new Error("evil even number!"));
        }
      })
  });
  
var b = new B();
try {
  console.log(b.m(5));
  console.log(b.m(6));
} catch (e) {
  console.log(e.message);
}
// PRINTS:
// 1
// evil even number!
{% endcodeblock %}

## Notes

### Shortcuts

If you want to weave just one advice, you may want to use a shortcut:

{% codeblock dcl.before() lang:js %}
var B1 = dcl(A, {
  method: dcl.before(function (msg) {
    console.log("Method was called with msg = " + msg);
  })
});
// is equivalent to
var B2 = dcl(A, {
  method: dcl.advise({
    before: function (msg) {
      console.log("Method was called with msg = " + msg);
    }
  })
});
{% endcodeblock %}

{% codeblock dcl.after() lang:js %}
var B3 = dcl(A, {
  method: dcl.after(function () {
    console.log("Method has finished.");
  })
});
// is equivalent to
var B4 = dcl(A, {
  method: dcl.advise({
    after: function () {
      console.log("Method has finished.");
    }
  })
});
{% endcodeblock %}

{% codeblock dcl.around() lang:js %}
var B5 = dcl(A, {
  method: dcl.around(function (sup) {
    return function (msg) {
      // let's ignore our parameter
      sub.call(this, "Canned response no matter what.");
    };
  })
});
// is equivalent to
var B6 = dcl(A, {
  method: dcl.superCall(function (sup) {
    return function (msg) {
      // let's ignore our parameter
      sub.call(this, "Canned response no matter what.");
    };
  })
});
// is equivalent to
var B7 = dcl(A, {
  method: dcl.advise({
    around: function (sup) {
      return function (msg) {
        // let's ignore our parameter
        sub.call(this, "Canned response no matter what.");
      };
    }
  })
});
{% endcodeblock %}

You can find those methods documented respectively in [dcl.before()](/2.x/docs/dcl_js/before/),
[dcl.after()](/2.x/docs/dcl_js/after/), and [dcl.around()](/2.x/docs/dcl_js/around/).

### More on order of advices

The described order is followed to the letter. Specifically I want to stress "regardless of their declaration order".
It doesn't matter in what order advices were declared.

Which is not true for simple faux-AOP wrapper-based implementations. To wit:

{% codeblock Wrapper-based faux-AOP lang:js %}
// UBER-SIMPLE FAUX-AOP

function wrapBefore (object, name, advice) {
  var sup = object[name];
  object[name] = function () {
    advice.apply(this, arguments);
    return sub.apply(this, arguments);
  };
}

function wrapAfter (object, name, advice) {
  var sup = object[name];
  object[name] = function () {
    try {
      var result = sub.apply(this, arguments);
      advice.call(this, arguments, result);
    } catch (e) {
      advice.call(this, arguments, e);
    }
    return result;
  };
}

function wrapAround (object, name, advice) {
  var sup = object[name];
  object[name] = function () {
    // for simplicity I assume that the advice takes
    // its super as its first parameter, and all arguments
    // as the second parameter
    advice.call(this, sup, arguments);
  };
}

// EXAMPLE

var x = {a: function () { console.log("HA!"); }};

wrapBefore(x, "a", function () { console.log("before"); });
wrapAround(x, "a", function (sup) {
  console.log("around: before calling");
  sup.apply(this, arguments);
  console.log("around: after calling");
});
wrapAfter(x, "a", function () { console.log("after"); });

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

In general the relative order of different wrapper-based advices will depend on their definition order, while in true AOP it is rigid. In our faux-AOP example, if our around advice doesn't call its super for any reason, `before` and/or `after` advices, depending on their order of wrapping, are never called, which is incorrect, and breaks the invariant.

While the order difference looks harmless, it prevents from using some important AOP techniques. For example, it prevents setting up a hook function (an after advice) that runs after all "normal" methods. See [multi-stage construction](/2.x/docs/general/multi-stage-construction/) for an interesting use case.
