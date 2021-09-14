---
title: Palm OS database formats
---

# Palm OS database formats
{:.no-toc}

This is the place in which we're going to document all the weird little things
about Palm OS application database formats that took us forever to figure out.

Contents:

* table of contents go here, hopefully
{:toc}


## Categories in AppInfo

TODO: document this stuff since I'm bound to forget the details later

<https://github.com/u1f408/palmrs/blob/f764b0f58691f7a7e4388b17d3bf5ea47be01612/palmrs-database/src/info/category.rs>


## ToDoDB

Basic format of records:

* `u16` due date, slightly weird to decode, `0xFFFF` means no due date set
  * Day: `field & 0x001F`
  * Month: `(field >> 5) & 0x000F`
  * Year: `((field >> 9) & 0x007F) + 1904`
* `u8` record priority & completion
  * Completion flag: `field & 0x80 != 0`
  * Priority: `field & 0x7F`
* Item text: null-terminated string
  * String can contain newlines (as `\n`)
  * If there is a null byte somewhere before the end of the record, the text
    _before_ that null byte is the item text, and the text _after_ is the
    "note" field
