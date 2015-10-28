# dwm - dynamic window manager

dwm is an extremely fast, small, and dynamic window manager for X. See the original README file for more info.

## Forked by Frantisek Kolacek

I was happily using dwm fork created by [bblaskovic](https://github.com/blaskovic/dwm) but then I took an arrow to the knee and decided to create my own. I patched the Vanilla dwm and configured it for my needs.

### List of applied patches:
- pertag
- systray
- nametag
- cfacts
- multimon (monitor marker)

### Requirements:
- libX11, libXft and libXinerama headers

### Recommended packages:
 - dmenu, terminus-fonts, xsel, i3lock, wmname

### Installation:
```
# dnf groupinstall 'Development Tools'
# dnf install libX11-devel libXft-devel libXinerama-devel
# dnf install dmenu terminus-fonts xsel i3lock wmname
$ make clean
$ make
# make install
```

