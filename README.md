# paupalou dotfiles

## dotfiles

structure and initial idea forked from 
[holman dofiles](https://github.com/holman/dotfiles)

## prequisites

- [zsh](https://github.com/zsh-users/zsh)
- [prezto](https://github.com/sorin-ionescu/prezto)

## install

```sh
git clone https://github.com/paupalou/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

## topical

(from holman)
Everything's built around topic areas. If you're adding a new area to your
forked dotfiles — say, "Java" — you can simply add a `java` directory and put
files in there. Anything with an extension of `.zsh` will get automatically
included into your shell. Anything with an extension of `.symlink` will get
symlinked without extension into `$HOME` when you run `script/bootstrap`.

(my addition)
You can create subfolders inside topic folders. Those will be created with the
same name into `$HOME` when you run `script/bootstrap` adding a dot at the
start to keep it hidden.

Look inside vim-nvim/config for example.

## components

There's a few special files in the hierarchy.

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/\*.symlink**: Any files ending in `*.symlink` get symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.
- **topic/subfolder/\*.symlink**: Same as previous but respecting subfolder
  tree structure.

## "external" topics

- **composer** : dependency management for php
- **ctags** : [universal ctags](https://ctags.io) to use with vim/nvim
- **fzf** : [best fuzzy-finder](https://github.com/junegunn/fzf) you can use. pure love.
- **ranger** : [file manager](https://github.com/ranger/range://github.com/ranger/ranger) with vim keybindings
- **tasks** : super lightweight [task manager](http://stevelosh.com/projects/t/) from the king steve losh, slightly modified
- **tmux** : defacto [terminal multiplexer](https://github.com/tmux/tmux)
- **vim-nvim** : text-editor , the special one, the only one.

