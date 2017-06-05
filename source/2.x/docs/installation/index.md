---
layout: page
title: "Installation"
date: 2012-07-21 13:19
comments: false
sharing: true
footer: true
---

*Version 2.x*

`dcl` can be installed with most popular package managers:

* `npm`:

  ```txt
  npm install --save dcl
  ```

* `yarn`:

  ```txt
  yarn add dcl
  ```

`dcl` uses UMD, so it can be used by `node` as is. AMD loaders (used in browsers)
are supported out of box too. If you prefer to use globals in your project,
just source `dcl` from `/dist/` directory:

```html
<script src='node_modules/dcl/dist/dcl.js'></script>
```

Alternatively, you can use https://unpkg.com/ with AMD or globals. For example:

```html
<script src='https://unpkg.com/dcl@latest/dist/dcl.js'></script>
```

You can always find the latest code in [github.com/uhop/dcl](https://github.com/uhop/dcl),
and copy necessary files manually, or clone the whole project, if you wish.
