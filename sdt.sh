#!/usr/bin/env sh

### /// setup-debian-termux // ConzZah /// ###

echo '== setup-debian-termux // (c) ConzZah 2026 =='

## update termux packages before continuing
apt update && yes| apt upgrade -y

## if proot-distro is not installed, do so now
! command -v proot-distro >/dev/null && \
apt install -y proot-distro

## set path to debian rootfs
debrootfs="$PREFIX/var/lib/proot-distro/containers/debian/rootfs/"

## if $debrootfs doesn't exists yet, install debian
[ ! -d "$debrootfs" ] && proot-distro install debian

## set $deb_alias
deb_alias='alias deb="proot-distro login debian"'

## if $deb_alias couldn't be found in .profile, add it
touch "$HOME/.profile"
! grep -q "$deb_alias" "$HOME/.profile" && \
printf '%s\n' "$deb_alias" >> "$HOME/.profile"

## install basic packages
proot-distro login debian -- apt install -yy build-essential git fastfetch

## login
proot-distro login debian
