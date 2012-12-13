---
layout: page
title: "getInherited()"
date: 2012-07-29 00:15
comments: false
sharing: true
footer: true
---

This function determines a super method dynamically. It returns it as result, but unlike
[inherited()](/docs/inherited_js/inherited) it doesn't call it immediately. If there is
no super method, a falsy value is returned.

While it is slower than the normal way to do supercalls with `dcl` (see the decorator
[dcl.superCall()](/docs/mini_js/supercall) for details), it doesn't require to modify
a method according to the double function pattern, and can be applied to
undecorated methods, which makes it suitable for fast prototyping, and
transitioning legacy code.

As soon as `inherited.js` is included, it mixes in `getInherited()` as a method to all
newly created objects, so you don't need to use the result of the module directly.

`getInherited()` works in strict mode.

## Description

This is a companion method for [inherited()](/docs/inherited_js/inherited). In fact,
it is used in its implementation. Just like [inherited()](/docs/inherited_js/inherited),
it doesn't require to decorate a method, and can be used to add a supercall to any
arbitrary method, which makes it suitable for transitioning legacy code or fast
prototyping:

{% codeblock getInherited() lang:js %}
var B = dcl(A, {
	// The getInherited() way:
	calcPrice1: function(x){
		var sup = this.getInherited(B, "calcPrice1");
		if(sup){
		    // Let's inflate price by 200%.
		    // Asking for a real price in three different
		    // yet equivalent ways:
			var realPrice1 = sup.apply(this, arguments);
			var realPrice2 = sup.apply(this, [x]);
			var realPrice3 = sup.call(this, x);
			// Now let's return it tripled:
			return realPrice1 + realPrice2 + realPrice3;
		}else{
			// There is no super method.
			return 0;
		}
	},

	// Compare it with dcl.superCall() example:
	calcPrice2: dcl.superCall(function(sup){
	    // Let's inflate price by 200%.
		return function(x){
			if(sup){
			    // Asking for a real price in three different
			    // yet equivalent ways:
				var realPrice1 = sup.apply(this, arguments);
				var realPrice2 = sup.apply(this, [x]);
				var realPrice3 = sup.call(this, x);
				// Now let's return it tripled:
				return realPrice1 + realPrice2 + realPrice3;
			}else{
				// There is no super method.
				return 0;
			}
		};
	})
});
{% endcodeblock %}

As you can see both `getInherited()` and [dcl.superCall()](/docs/mini_js/supercall) look
almost identical. The difference is:

* [dcl.superCall()](/docs/mini_js/supercall) works statically and does not incur run-time penalties.
* [dcl.superCall()](/docs/mini_js/supercall) requires a double function pattern described in [Supercalls in JS](/docs/general/supercalls).

For more details please take a look [inherited()](/docs/inherited_js/inherited).

## FAQ

### When should I use `getInherited()`?

There are three common scenarios when using `getInherited()` is beneficial:

1. A method should make several calls to its super method. By using `getInherited()`
   and reusing its result, you save CPU ticks making the whole method faster. For even
   faster results consider using [dcl.superCall()](/docs/mini_js/supercall).
2. Your code behaves differently when there is no super method, and the default
   provided by [inherited()](/docs/inherited_js/inherited) just doesn't work for you.
3. While debugging, you don't want to go inside [inherited()](/docs/inherited_js/inherited)
   (it is debugging-friendly, yet you may want to skip it completely while debugging).
   In this case you step over calls to `getInherited()` and debug your super methods
   directly.
