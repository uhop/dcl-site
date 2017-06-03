---
layout: page
title: "ChangeLog"
date: 2013-10-04 22:46
comments: false
sharing: true
footer: true
---

*Version 1.x*

## Major version: 1.1

### 1.1.3

1.1.3 introduces a check against a wrong type of super (e.g., making a super call for numeric property), adds new CI targets, and fixes a version for [bower](http://bower.io/).

Blog entry: [1.1.3: micro update](/blog/2015/04/06/1-dot-1-3-micro-update).

### 1.1.2

Technical update: a massive cleanup of internals to make them more readable and maintainable.

Blog entry: [1.1.2: technical release](/blog/2014/12/28/1-dot-1-2-technical-release).

### 1.1.1

Minor update that includes two bug fixes:

* Bugfix: a stray comma in a test file, which acted up in legacy browsers.
* Bugfix: [dcl.mix()](./mini_js/mix) was called directly in the base modules preventing it from being monkey-patched.

Blog entry: [Micro update: 1.1.1](/blog/2013/11/05/micro-update-1-dot-1-1).

### 1.1.0

Major update, which includes support for legacy browsers (IE < 9). It doesn't affect existing users, because it doesn't change the API or its semantics, but provides an option for legacy applications.

* Added metadata for an extended Dojo release.
* Internal code is better formatted, better documented, variables are renamed to use more suggestive names.
* Added [legacy.js](./legacy_js) module, which is a substitute for [mini.js](./mini_js) in legacy environments.

Blog entry: [1.1: legacy](/blog/2013/10/04/1-dot-1-legacy).

## Major version: 1.0

### 1.0.4

Technical release. No functional changes, just a new tag and new file with metadata for [bower](http://bower.io/).

Blog entry: [1.0.4: added to Bower](/blog/2013/07/24/1-dot-0-4-added-to-bower/).

### 1.0.3

Minor update, which includes a bug fix, and improved testing.

* Bugfix: in some cases when using a native constructor created without `dcl` it was not called when creating an object. This bug is fixed and relevant tests were added.
* All tests are consolidated using [heya-unit](https://github.com/heya/unit). No more manual tests.
* Added an automated testing in [PhantomJS](http://phantomjs.org/) environment.
* Increased test coverage.

Blog entry: [Update: 1.0.3](/blog/2013/05/30/update-1-dot-0-3).

### 1.0.2

An update to accommodate some security restrictive embedded environments.

* Some instances of `new Function` were replaced with `function(){}` to bypass [Content Security Policy](https://dvcs.w3.org/hg/content-security-policy/raw-file/bcf1c45f312f/csp-unofficial-draft-20110303.html) restrictions, because `new Function` even without any parameters is considered to be `eval` (???), and forces to allow `eval` globally.

Blog entry: [Micro update: 1.0.2](/blog/2012/12/30/micro-update-1-dot-0-2).

### 1.0.1

Minor update, mostly housekeeping.

* Added [getInherited()](./inherited_js/getinherited) as an alias for [inherited.get()](./inherited_js/get) to simplify its use. Now there is no need to use `call()` or `apply()` to specify its instance.
* Added tests for `dcl` exceptions.
* Added tests for canned advices and mixins.
* Changed export names for `<script>` inclusion.
* Error messages are better formatted.
* Minor clean up, better comments, documentation updates.

Blog entry: [1.0.1 is out](/blog/2012/12/18/1-dot-0-1-is-out).

### 1.0.0

The initial public release.

Blog entry: [1.0 is public](/blog/2012/10/05/1-dot-0-is-public).
