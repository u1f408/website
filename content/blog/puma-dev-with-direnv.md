---
kind: article
title: puma-dev with direnv
created_at: 2021-11-21T00:00:00Z
tags:
  - development 
---

# `puma-dev` with `direnv`

I use [`direnv`][] in combination with Nix for managing the environment for
nearly all of my projects. Now that I'm using [`puma-dev`][], I wanted to make
that start apps in the Nix environment specified in the project's `shell.nix`,
as well as have any other `direnv` stuff work.

It took me a little bit to figure this out, so in case it's useful, here you
go. Throw this in your `~/.powconfig` and it should just work!

```shell
ABSPWD="$(readlink "${PWD}")"

# Load direnv, if allowed
if test -f .envrc; then
	echo "powconfig: loading direnv from ${ABSPWD}"
	eval "$(direnv exec "${ABSPWD}" direnv dump bash)"
fi
```

[`direnv`]: https://direnv.net
[`puma-dev`]: https://github.com/puma/puma-dev
