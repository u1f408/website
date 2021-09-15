---
title: Palm OS development & tooling
---

# Palm OS development & tooling
{:.no_toc}

Also known as: _we really like old technology, it seems…_

* table of contents go here, hopefully
{:toc}


## palm.rs

palm.rs ([source][palmrs-repo], [docs][palmrs-docs]) is a collection of library
crates and command-line tools for interacting with Palm OS devices, and the
data stored on them.

Current status:

* Mostly working parser for Palm OS databases (PRC/PDB files)
* Some debugging tools for Palm OS files:
  * `palmrs-db-dump` to dump the headers of a Palm OS database in a
    semi-human-readable format, optionally printing the content of each record
    as a pretty hex dump

Short-term plans:

* Tool for bidirectional sync between a Palm OS "Tasks" app database, and a
  `todo.txt` formatted file 
  * Optionally keeping "completed" tasks in a `done.txt` file, as is common

Long-term plans:

* HotSync desktop implementation


### Blog posts about palm.rs

Collated here for easy reference.

<ul>
<% sorted_articles.filter{|x| x[:tags].include?('palm.rs')}.each do |article| %>
  <li><ul class="inline-list">
    <li><a href="<%= @config[:base_url] + article.reps[:default].path %>"><%= article[:title] %></a></li>
    <li><span>posted: </span><%= article[:created_at].strftime("%Y-%m-%d") %></li>
  </ul></li>
<% end %>
</ul>


## Modern Palm OS compiler toolchain

Also known as: _screw using GCC 2, if I'm writing C I want it to be nice!_

The idea here is to port as much as possible of the GCC/binutils patchsets that
make up `prc-tools` to a modern toolchain (GCC 11.2, binutils 2.37), and see
how hard it'll be to get some Palm OS applications compiling with that new
toolchain.

Work in progress.


## Our own Palm OS applications

Nothing yet. Depends on getting the above-mentioned modern compiler toolchain
working.


## Resources

* [Palm OS database formats][db-formats] - our own accumulation of
  documentation on decoding various Palm OS application record databases


### Test & example files

* `hello.prc` - a simple "hello world" application ([source][hello-source],
  from `prc-tools-remix`)
  * [hello-v1.prc][hello-prctools]: compiled with `prc-tools-remix`
  * ~~hello-v2.prc: compiled with the modern toolchain~~ (available when the
    modern toolchain works)
* `ToDoDB.pdb` - a Palm OS Tasks / To Do application database, populated with
  test data
  * [ToDoDB-os4.pdb][]: exported from Palm OS Emulator running Palm OS 4 (usig
    an m505 ROM), manually populated


[palmrs-repo]: https://github.com/u1f408/palmrs/
[palmrs-docs]: https://u1f408.github.io/palmrs/
[db-formats]: <%= @config[:base_url] %>/projects/palmos/db-formats/
[hello-source]: https://github.com/jichu4n/prc-tools-remix/tree/master/tools/hello-world-app/
[hello-prctools]: https://palm.sfo2.cdn.digitaloceanspaces.com/hello/hello-v1.prc
[hello-modern]: https://palm.sfo2.cdn.digitaloceanspaces.com/hello/hello-v2.prc
[ToDoDB-os4.pdb]: https://palm.sfo2.cdn.digitaloceanspaces.com/test-data/ToDoDB-os4.pdb
