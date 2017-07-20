---
layout: post
title: "Using dcl with ES6"
date: 2017-07-19 23:25:35 -0500
comments: true
categories: announce
---

`dcl` can be used with projects based on ES6. Unfortunately some tools had problems with `dcl` in a certain configuration:

* For Node-based projects the browser globals distribution (see [Installation](/2.x/docs/installation/)) cannot be used.
* Tools like [webpack](https://webpack.github.io/) are difficult to configure to bypass certain modules from totally unnecessary compilation step.
  * [Babel](https://babeljs.io/) is used to compile from ES6 to ES5 all modules regardless of the fact that `dcl` uses strict ES5 subset.
  * Babel has problems with UMD unable to decipher static dependencies from it.

To make `dcl` more Babel-friendly so it can be easily used in [React](https://facebook.github.io/react/)-based projects, or any projects, where tooling is based on webpack, new distribution was introduced: `/es6/`.

Starting with version 2.0.3 `dcl` has a special directory `/es6/`, which contains processed modules with dependencies done in the ES6 style with `import` statements. They expose their APIs with `export default`.

<!-- more -->

This feature is modeled after `/dist/` directory, which hosts processed modules with browser global-based dependencies ready to be included with `<script>` or concatenated with other browser-ready files.

In order to use `dcl` in your ES6-based project just import its modules like that:

```js
import dcl from `dcl/es6/dcl`;
import advise from `dcl/es6/advise`;

// more examples
import registry from `dcl/es6/utils/registry`;
```
