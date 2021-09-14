---
kind: article
title: "palm.rs update #1: 2021-09-15"
created_at: 2021-09-15T00:00:00Z
tags:
  - development
  - palmos
---

# palm.rs update #1: 2021-09-15

A couple days ago (I think? The days are blurring together), I decided that I
wanted to write some tools for interacting with Palm OS devices (and their
data) from a _modern_ Linux system. `pilot-link` is horribly outdated (and
riddled with bugs, besides), and I don't really want to use an ancient Windows
machine just to sync my LifeDrive.

And so, [palm.rs][] was born. palm.rs is the beginning of a set of libraries
and command-line tools for managing data from Palm OS devices, and will
(hopefully, eventually) include a functional HotSync manager.


## The beginnings: Palm OS databases

I started off with writing the `palmrs-database` crate, a general-purpose
library for reading and writing Palm OS database files. Pretty essential to
have this to do literally anything else, so it was the first thing that was
worked on.

It's currently in a state where it can parse Palm OS databases - both PDB and
PRC formats (since they're basically the same anyway) - into a form that other
tools can take and run with.

I also wrote the `palmrs-db-dump` command-line tool, which prints the parsed
headers of a Palm OS database, and optionally prints a pretty hex dump of each
individual section. It's basically [palmdump][], but using the fancy new
`palmrs-database` crate instead of being written in an ancient C dialect.

Here's a screenshot of `palmrs-db-dump` in action, dumping a "hello world"
Palm OS application:

[![][ss-dbdump]][ss-dbdump]


## HotSync conduits, sort of: todo.txt support

The next thing (which is part of the reason I started this whole damn project
in the first place) is a way to transform a Palm OS `ToDoDB.pdb` into a
[todo.txt][] formatted file. Having the `palmrs-database` crate implemented in
the way that it is made this relatively easy, after some faffing around with
[figuring out the damn `ToDoDB` record format][db-formats-todo].

In it's current state, the `palmrs-conduit-todotxt` binary works to transform a
`ToDoDB.pdb` into a `todo.txt` file (or, two files: `todo.txt` and `done.txt`),
and this is working rather well:

[![][ss-conduit-todotxt]][ss-conduit-todotxt]

The next step: converting a `todo.txt` file back into a `ToDoDB.prc` file, such
that I can throw that at Palm Desktop and cross my fingers.


## More… tomorrow.

It's getting ever closer to 05:30 local time, and we've been awake for 45 hours.

Maybe it's time for a nap.


[palm.rs]: https://github.com/u1f408/palmrs/
[palmdump]: http://fourmilab.ch/palm/palmdump/
[todo.txt]: https://todotxt.org
[db-formats-todo]: https://catstret.ch/projects/palmos/db-formats/#tododb
[ss-dbdump]: https://oops-all-kittens.sfo2.digitaloceanspaces.com/blog/2021-09-15-050702_761x1025_scrot.png
[ss-conduit-todotxt]: https://oops-all-kittens.sfo2.digitaloceanspaces.com/blog/2021-09-15-045106_963x453_scrot.png
