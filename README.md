# My dotfiles

Here are my local dotfiles mainly including

* `i3gaps` as wm
* `neovim` as editor
* `rofi` as dmenu replacement
* `dunst` as notification deamon
* `polybar` as status bar

Almost all graphical programs in this repo use Xresources.
Different color schemes and backgrounds may be available as tags. Those will most certainly also contain older versions of other files.


# Installation

Follow these steps to install as a bare repository
You might want do backup your current configs first in case something goes wrong or you dislike a change.
``` sh
git clone --bare https://github.com/jzbor/dotfiles $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f
```

# Theming

#### Current wallpaper:
![Wallpaper (No JPEG wallpaper found)](.config/background.jpg)

# Dependencies and Programs
[You find a list with the arch/manjaro package name here](.config/assets/programs.txt)
