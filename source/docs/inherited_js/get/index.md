---
layout: page
title: "inherited.get()"
date: 2012-07-29 00:15
comments: false
sharing: true
footer: true
---

This function is an alias for [getInherited()](/docs/inherited_js/getinherited).

## Description

See [getInherited()](/docs/inherited_js/getinherited) for details.

## Examples

{% codeblock inherited.get() lang:js %}
var B = dcl(A, {
  // The inherited.get() way:
  calcPrice1: function(x){
    var sup = this.inherited.get.call(this, B, "calcPrice1");
    if(sup){
      return sup.apply(this, arguments);
    }else{
      // There is no super method.
      return 0;
    }
  },

  // The getInherited() way:
  calcPrice2: function(x){
    var sup = this.getInherited(B, "calcPrice2");
    if(sup){
      return sup.apply(this, arguments);
    }else{
      // There is no super method.
      return 0;
    }
  },

  // Compare it with dcl.superCall() example:
  calcPrice3: dcl.superCall(function(sup){
    // Let's inflate price by 200%.
    return function(x){
      if(sup){
        return sup.apply(this, arguments);
      }else{
        // There is no super method.
        return 0;
      }
    };
  })
});
{% endcodeblock %}

## FAQ

### When should I use `inherited.get()`?

It is there mostly for legacy reasons. In general it is recommended to use
[getInherited()](/docs/inherited_js/getinherited).
