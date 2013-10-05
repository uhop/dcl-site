---
layout: page
title: "legacy.js"
date: 2013-10-04 19:33
comments: false
sharing: true
footer: true
---

`legacy.js` is a drop-in replacement for [mini.js][] (added in `dcl` 1.1.0), which supports legacy browsers (tested with IE8). It has the same API, and the same functionality.

While it is possible to use `legacy.js` instead of [mini.js][] with `node.js` and modern browsers, it is not advised, because `legacy.js` is slower than [mini.js][].

## Background

When `dcl` was released originally, it supported only modern environments. The major problem with legacy environments was not their obsolescence or backwardness, or lack of certain features, but shameful bugs in their implementation of JavaScript. The biggest of them is a `for in` loop bug, which skips some property names.

In general it means that the normal `for in` loop:

```js
for(var key in object){
  var value = object[key];
  // do something
}
```

Should be approximated like that:

```js
for(var key in object){
  var value = object[key];
  // do something
}

var hidden = ["hasOwnProperty", "valueOf", "isPrototypeOf",
  "propertyIsEnumerable", "toLocaleString", "toString", "constructor"];

for(var i = 0; i < hidden.length; ++i){
  var key = hidden[i];
  var value = object[key];
  if(value !== Object.prototype[key] || !(key in Object.prototype)){
    // do something like above
  }
}
```

Obviously such approximation is inexact, and more expensive space-wise, and processor-wise. This is why it was rejected initially. Later on a legacy version of [mini.js][] was designed as a replacement, keeping the canonical version of `dcl` small and fast, yet providing an option for legacy environments (older version of IE).

## FAQ

### How can I substitute `mini.js` with `legacy.js` conditionally?

First of all, you need to do it only in a browser environment. Over there an AMD loader will help us. For example, `tests\tests.html` uses a conditional comment technique targeting legacy IE browsers specifically:

{% codeblock Loading legacy.js conditionally lang:js %}
(function(){
    var paths = {
        domReady: "https://raw.github.com/requirejs/domReady/latest/domReady"
    };
    /*@cc_on
    if(@_jscript_version < 9){
        paths["../mini"]  = "../legacy";
        paths["dcl/mini"] = "dcl/legacy";
    }
    @*/
    require.config({
        baseUrl: ".",
        packages: [
            {name: "heya-unit",
            location: "../node_modules/heya-unit"},
            {name: "heya-ice",
            location: "../node_modules/heya-unit/node_modules/heya-ice"},
            {name: "heya-unify",
            location: "../node_modules/heya-unit/node_modules/heya-unify"}
        ],
        paths: paths
    });
})();
require(["require", "./tests", "domReady!"], function(require){
    var test = require("./tests");
});
{% endcodeblock %}

You can see how the script manipulates `paths` of `require.config` to load `legacy.js` instead of [mini.js][] on IE < 9.

Read more about this technique in [MSDN: @cc_on][].

### Can I just replace `mini.js` with `legacy.js` in my own IE-specific application?

Yes. But remember that when you handle 3rd-party files manually, you are on your own, and all mistakes are yours.

### I built all my JS files into two layers: normal, and legacy. How can I load them conditionally?

One way to do it is to use HTML-level conditional comments supported by IE. Read more about this technique in [MSDN: About conditional comments][].

### Does it work on IE6?

Unlikely -- it was never tested on IE6, and so far no requests were made for such environment. But you can always try.

Gentle reader, be warned: IE6 had even more implementation bugs than IE7/IE8.

[mini.js]:  /docs/mini_js  mini.js
[MSDN: @cc_on]: http://msdn.microsoft.com/en-us/library/ie/8ka90k2e(v=vs.94).aspx
[MSDN: About conditional comments]: http://msdn.microsoft.com/en-us/library/ms537512(VS.85).aspx
