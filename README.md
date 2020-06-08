# My dotfiles

Here are my local dotfiles mainly including

* `i3gaps` as wm
* `neovim` as editor
* `rofi` as dmenu replacement
* `dunst` as notification deamon
* `polybar` as status bar

Almost all graphical programs in this repo use Xresources.
Different color schemes and backgrounds may be available as tags.
Those will most certainly also contain older versions of other files.

**Feel free to adapt and adjust everything to your needs**


# Installation

## Installing the Repo
Follow these steps to install as a bare repository.
You might want do backup your current configs first in case something goes wrong or you dislike a change.
``` sh
git clone --bare https://github.com/jzbor/dotfiles $HOME/.dotfiles
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME checkout -f
```
You can now find the git files in the ~/.dotfiles directory, whilst the file tree is located at your $HOME directory.
This kind of separeted structure is known as bare repository.
The command `config` can be used to do git transactions on your dotfiles.
``` sh
# Examples:
config commit -am "Some changes"
config push
```
In order for everything to work as intended you will need to restart.
All the scripts are added to $PATH from now on, so you can call them directly without their directory.

## Setting the Shell
You might also want to set your shell to `zsh` if you have it installed:
``` sh
sudo usermod --shell /bin/zsh $USER
```

## Installing Dependencies
Dependencies and relevant programs are listed in [the programs directory](.config/assets/programs/).
If you like to install all of them (on arch) you can run `~/.config/assets/programs/install.sh \*`.
You can also just install the groups you like to, for example `~/.config/assets/programs/install.sh tools-basic.txt office.txt`
This will also install the `yay` aur helper.

## Keybindings
You will also probably want to check the keybindings and adapt them to your needs.
The keybindings are listed in [.config/i3/config](.config/i3/config).
There are also lots of helpful bindings for scripts that for example allow you to mount/unmount drives or insert emojis.

## Customizing
If you want to change the main colors edit them in [.Xresources](.Xresources).
These are the variables you will want to customize:
```
!! My theme
#define myBackground			#0f1418
#define myBackgroundTrans		#e00f1418
#define myForeground			#ebdbb2
#define mySelector			#b83e1e
#define myUrgent			#d78272
```

To change the wallpaper you should use the [wallpaper.sh](.scripts/de/wallpaper.sh) script.
``` sh
# Usage:
wallpaper.sh	    -> Prints the location of the current wallpaper
wallpaper.sh load   -> Loads the current wallpaper
wallpaper.sh file   -> Set new wallpaper
```

## Spicetify
`Spicetify` is a program that helps you customize `Spotify`.
Take a look at the [repository's wiki](https://github.com/khanhas/spicetify-cli/wiki) to get started.


# Theming

#### Current wallpaper:
[Wallpaper](.config/assets/)
