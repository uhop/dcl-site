---
layout: page
title: "Installation"
date: 2017-06-09 13:19
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl` can be installed with most popular package managers:

```
npm install --save dcl@2
```

```
yarn add dcl@2
```

When the package is installed, you can refer to individual files mentioned in the documentation.

`dcl` uses UMD, so it can be used by `node` as is. AMD loaders (used in browsers) are supported out of box too. If you prefer to use globals in your project, just source `dcl` from `/dist/` directory:

```html
<script src='node_modules/dcl/dist/dcl.js'></script>
```

For ES6-based projects, especially ones using [Babel](https://babeljs.io/) (e.g, [React](https://facebook.github.io/react/), or anything [webpack](https://webpack.github.io/)-based), starting with 2.0.3 the special distribution is generated in `/es6/` directory, which can be used like that:

```js
import dcl from `dcl/es6/dcl`;
import advise from `dcl/es6/advise`;
```

Alternatively, you can use https://unpkg.com/ with AMD:

```html
<script src='https://unpkg.com/dcl@latest/dcl.js'></script>
```

or globals:

```html
<script src='https://unpkg.com/dcl@latest/dist/dcl.js'></script>
```

You can always find the latest code in [github.com/uhop/dcl](https://github.com/uhop/dcl), and copy necessary files manually, or clone the whole project, if you wish.

## Globals

Here is the full list of global names used by a version in `/dist/` directory:

<div class="table-begins"></div>

| File name               | Comment                 | Main global              |
|-------------------------|-------------------------|--------------------------|
| `dcl.js`                | main OOP + AOP + chains | `dcl`                    |
| `advise.js`             | object-level AOP        | `advise`                 |
| `debug.js`              | debugging               | `dcl`                    |
| `advices/counter.js`    | advice                  | `dcl.advices.counter`    |
| `advices/flow.js`       | advice                  | `dcl.advices.flow`       |
| `advices/memoize.js`    | advice                  | `dcl.advices.memoize`    |
| `advices/time.js`       | advice                  | `dcl.advices.time`       |
| `advices/trace.js`      | advice                  | `dcl.advices.trace`      |
| `bases/Mixer.js`        | base "class"            | `dcl.bases.Mixer`        |
| `bases/Replacer.js`     | base "class"            | `dcl.bases.Replacer`     |
| `mixins/Cleanup.js`     | mixin                   | `dcl.mixins.Cleanup`     |
| `mixins/Destroyable.js` | mixin                   | `dcl.mixins.Destroyable` |
| `utils/registry.js`     | utility                 | `dcl.utils.registry`     |
