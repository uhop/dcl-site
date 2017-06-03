---
layout: post
title: "Micro update: 1.1.1"
date: 2013-11-05 16:31
comments: false
categories: announce
---

New release of `dcl` (1.1.1) includes two minor bug fixes:

* Bugfix: a stray comma in a test file, which acted up in legacy browsers.
* Bugfix: [dcl.mix()](/1.x/docs/mini_js/mix) was called directly in the base modules preventing it from being monkey-patched.

Most users can safely skip this update, unless they are directly affected by the monkey-patch bug.
