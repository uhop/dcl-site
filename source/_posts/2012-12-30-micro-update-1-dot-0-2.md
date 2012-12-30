---
layout: post
title: "Micro update: 1.0.2"
date: 2012-12-30 14:20
comments: true
categories: announce
---

New update was pushed out. Changes:

* Some instances of `new Function` were replaced with `function(){}`
  to bypass [Content Security Policy](https://dvcs.w3.org/hg/content-security-policy/raw-file/bcf1c45f312f/csp-unofficial-draft-20110303.html) restrictions,
  because `new Function` even without any parameters is considered to be `eval`
  (???), and triggers a necesity to allow `eval` globally.

This update doesn't affect any functionality, and can be safely skipped, if you
don't work with security-constrained environments.
