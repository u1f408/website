---
title: Operating system development
---

# Operating system development

This page is forever a work in progress.

## slOS

slOS is our current OS project.

- [Source code (on GitHub)][gh-slos]
- [Somewhat regular updates (on our Waterfall blog)][wf-slos]

Work-in-progress features:

- Hook-based system for running things in `kmain` (which can be manipulated
  at runtime)
- Trait-based hardware abstraction layer
    - Implementation of the HAL running as a process on a host UNIX system
- Trait-based filesystem handling, with core implementations of:
    - An in-memory temporary filesystem
    - (soon) A union filesystem wrapper
    - An overlay filesystem wrapper (read-only base, read/write overlay)
    - Read-only filesystem view of a Quake 2 PAK archive (via [rpak][])

We'll see where this one goes!

## Previous projects

- [polymorphOS][]
    - Our first Rust OS project
    - Has served as inspiration for slOS (and, in fact, some slOS code
      has been modified from stuff in polymorphOS)

[gh-slos]: https://github.com/u1f408/slos
[wf-slos]: https://blobcat.waterfall.social/tagged/softwaredev:slos
[polymorphOS]: https://sr.ht/~ren/polymorphOS
[rpak]: https://lib.rs/crates/rpak
