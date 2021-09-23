---
kind: article
title: "Oracle Cloud and a Raspberry Pi: A development workstation on the cheap"
created_at: 2021-09-10T00:00:00Z
tags:
  - development
---

# Oracle Cloud and a Raspberry Pi: A development workstation on the cheap

Recently, we've had to massively downsize the amount of local compute resources
we have access to. Not knowing where we were going to be moving to after ending
the lease on our apartment, facing the threat of homelessness, meant that
making sure we're still able to do the development work that we want to do from
wherever we end up was a high priority.

We found a rather elegant solution to this, however.

## Oracle? Giving us free stuff?

Oracle Cloud's free tier is Extremely Generous - giving you two AMD EPYC
virtual machines with 1GB of RAM each; as well a pool of 4 Ampere aarch64 CPU
cores and 24GB of RAM, that you're able to split up as you wish. 

Our new remote development workstation is one of those Ampere virtual machines,
with 3 CPU cores and 16GB of RAM assigned (the remaining CPU core and RAM are
assigned to another VM).

### NixOS time!

Thankfully, [nixos-infect][] works perfectly on the Oracle Cloud Ampere VMs,
and so we were able to get a development setup running rather quickly - we
could just run the script to set up a base NixOS installation, clone
[our NixOS configuration][nixconf], add a new host profile, and deploy.

A few hours messing with our `tmux` and `neovim` configurations, setting up
nginx, fighting with our own per-machine certificate generation tooling, and
we're away.

## The spare Pi 4

After seeing [a blog post by Remy "raymii" van Elst][raymii-icewm] -
specifically about using a Raspberry Pi 4 as a main computer - come up on a
link aggregator that we sometimes pay attention to, we were somewhat intrigued
by the idea. We thought… y'know, this would be the perfect opportunity to see
if something like that setup would work for us.

We set up the aarch64 version of Arch Linux ARM on a microSD card, threw that
into the Pi, and started configuring the system. 

### IceWM

We've always been rather fond of IceWM, and seeing the aforementioned blog post
inspired us to give it a try again - given how little resources it uses, it's
perfect for the Pi.

We haven't bothered to do anything pretty with it, we're using the (rather
boring) "icedesert" theme, but it doesn't need to look pretty when the only
time we ever pay attention to it is when we're launching something, or trying
to figure out which of our terminal windows contains which `mosh` session.

Here's our `~/.icewm/preferences` (heavily inspired by the configuration in
raymii's post):

```
MenuMouseTracking=1
SmartPlacement=1
SnapMove=1

TaskBarShowMailboxStatus=0
TaskBarShowWindowListMenu=0
TaskBarShowWorkspaces=0

ActiveButtonFontNameXft="sans-serif:size=10:bold"
ActiveTaskBarFontNameXft="sans-serif:size=10:bold"
ActiveWorkspaceFontNameXft="sans-serif:size=10"
ApmFontNameXft="monospace:size=12"
ClockFontNameXft="monospace:size=12"
TitleFontNameXft="sans-serif:size=10"
ToolButtonFontNameXft="sans-serif:size=10"
ToolTipFontNameXft="sans-serif:size=10"

KeyWinMenu=""
KeySysCollapseTaskBar=""
KeySysAddressBar="Alt+Space"

NetworkStatusDevice=""

DesktopBackgroundImage="~/.wallpaper.jpg"
DesktopBackgroundScaled=1
```

And, our `~/.icewm/startup`:

```shell
#!/usr/bin/env bash

# background
icewmbg &

# notification daemon
/usr/lib/notification-daemon-1.0/notification-daemon &

# networkmanager
sleep 1 && nm-applet &
```

### The obligatory neofetch screenshot

<%= imglink 'https://media.catstret.ch/post-assets/oci-rpi4-neofetch.png', alt: "neofetch on the Pi 4, with a Hatsune Miku wallpaper" %>

## Putting it together

After slightly modifying our usual `tmux` configuration on the Pi, a bit of
playing with the settings for alacritty, and generating an SSH key - we have
liftoff!

So far, we've done a fair amount of work on a couple of big projects using this
setup ([Kūkupa][] and [re:connect][], if you were wondering), plus a little bit
of playing around with [slOS][], our pet operating system project. Everything
works perfectly, compile times are relatively fast on the Ampere VM (especially
for only having 3 CPU cores assigned), and we're extremely happy with this.

Here's a screenshot (which has also been posted to our Twitter, so you may have
already seen it!) of this setup in action, in the midst of some feature
development in Kūkupa:

<%= imglink 'https://media.catstret.ch/post-assets/oci-rpi4-kukupa.png', alt: "Kūkupa development on the new setup" %>

This was mostly a rambling mess of a blog post, but oh well :)

[Kūkupa]: https://gitlab.com/againstprisons/kukupa
[re:connect]: https://gitlab.com/againstprisons/reconnect
[slOS]: https://github.com/u1f408/slos
[nixos-infect]: https://github.com/elitak/nixos-infect
[nixconf]: https://github.com/u1f408/nixconf
[raymii-icewm]: https://raymii.org/s/blog/Using_IceWM_and_sharing_my_config_and_tips_tricks.html
