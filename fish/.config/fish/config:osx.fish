set fish_pager_color_progress brblack --background=brmagenta
set fish_greeting

# XDG_CONFIG_HOME
set -gx XDG_CONFIG_HOME $HOME/.config

# local bin path
setpath $HOME/.local/bin

# neovim
set -gx EDITOR nvim

set config_files (find $HOME/.dotfiles -mindepth 2 ! -path "*/fish/*" -type f -name  "*.fish")

# source fish files
for file in $config_files
  source $file
end

# tmux
if status is-interactive
and not set -q TMUX
  exec tmux -f ~/.config/tmux/tmux.conf
end

# keybindings
bind \cb backward-word
bind \ct _fzf_search_directory

# fzf
set fzf_fd_opts --hidden --exclude=.git --exclude=node_modules
set fzf_preview_dir_cmd exa --all --color=always

# fzf.vim
set -x FZF_DEFAULT_COMMAND fd --type f

# tide
set -g tide_right_prompt_items

# aws-cli
setpath /usr/local/bin

# virtualfish
if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
end
