# l00sed's dotfiles

## Dotter configs

This repo uses a tool called [dotter](https://github.com/SuperCuber/dotter) to organize and maintain a variety of configurations.

### Configuration

The `.dotfiles/` repo should be located at your user's home directory.

Create a `~/.dotfiles/.dotter/local.toml` file.
Look at `~/.dotfiles/.dotter/global.toml` to see the available packages.

For example, your `local.toml` config could be:

```
# An array of the names of all packages that are selected.
# Only the files and variables that belong to packages in this list are kept.
packages = [
  "alacritty",
  "bash",
  "coc",
  "compton",
  "fusuma",
  "i3",
  "input",
  "kitty",
  "pipe-viewer",
  "ripgrep",
  "rofi",
  "screenkey",
  "tmate",
  "tmux",
  "vim",
  "Xresources",
  "zsh"
]
```
