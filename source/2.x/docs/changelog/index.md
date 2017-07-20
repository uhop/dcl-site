---
layout: page
title: "ChangeLog"
date: 2017-06-04 22:46
comments: false
sharing: true
footer: true
---

*Version 2.x*

## Major version: 2.0

### 2.0.5

`es6` distribution was regenerated to update corresponding modules. The final version was successfully used in a real React project to verify the correctness.

No need to upgrade for most users.

### 2.0.4

It turned out that depending on settings Babel may have a problem with an arrow function in ES6 prologue. It was downgraded to a regular function, fixed upstream, and propagated to `dcl`.

No need to upgrade for most users.

### 2.0.3

Added new specialized distribution similar to `dist`: `es6`. While modules in `dist` are based on browser globals, and ready to be added with `<script>`, files in `es6` follow the ES6 module conventions, and [Babel](https://babeljs.io/)-friendly. Use them right away with [React](https://facebook.github.io/react/) projects, practically any [webpack](https://webpack.github.io/)-based projects, and anything based on Babel.

No need to upgrade for most users.

### 2.0.2

Stability fix: some objects can have `hasOwnProperty()` method overwritten preventing `dcl` from working properly. In those cases all calls like `o.hasOwnProperty(name)` were replaced with more stable version:

```js
Object.prototype.hasOwnProperty.call(o, name);
```

Additionally a new utility was introduced: `utils/registry.js`. The [registry](/2.x/docs/utils/registry/) plugs in `dcl`, and returns [Map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Map)-like API, so a user can interrogate what constructors are registered, and retrieve them by their `declaredClass` names. Very useful for development, and to access constructors indirectly using names.

No need to upgrade for most users.

### 2.0.1

Updated links on the web site and in README of the project. No need to upgrade for most users.

### 2.0.0

The initial public release.

Blog entry: [New major release: 2.0](/blog/2017/06/09/new-major-release-2-dot-0/).
