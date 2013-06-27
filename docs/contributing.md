# Contributing to Lists

- [Introduction](#introduction)
- [Pull Requests](#pull-requests)
- [Coding Guidelines](#coding-guidelines)

<a name="introduction"></a>
## Introduction

Lists is free, open-source software, meaning anyone can contribute to its development and progress. Lists source code is currently hosted on [WikiMedia infrastructure](https://git.wikimedia.org/summary/?r=labs/tools/lists.git). There is also a [github](github.com/wikimedia/labs-tools-lists/) copy which provides an easy method for forking the project and merging your contributions.

<a name="pull-requests"></a>
## Pull Requests

The preferred tool to create pull requests is [gerrit](https://gerrit.wikimedia.org/r/#/admin/projects/labs/tools/lists) but is also possible to create them on [github](github.com/wikimedia/labs-tools-lists/) and the system will automagically ope them on gerrit too.

<a name="coding-guidelines"></a>
## Coding Guidelines

Lists follows the [PSR-0](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-0.md) and [PSR-1](https://github.com/php-fig/fig-standards/blob/master/accepted/PSR-1-basic-coding-standard.md) coding standards. In addition to these standards, below is a list of other coding standards that should be followed:

- Namespace declarations should be on the same line as `<?php`.
- Class opening `{` should be on the same line as the class name.
- Function and control structure opening `{` should be on a separate line.
- Always use `AND` and `OR`. Never use `&&` or `||`.
- Interface names are suffixed with `Interface` (`FooInterface`)
- Controller names are suffixed with `Controller` (`FooController`)
