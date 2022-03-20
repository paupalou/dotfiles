set fish_pager_color_progress brblack --background=brmagenta
set fish_greeting

set -gx EDITOR nvim
set -gx XDG_CONFIG_HOME $HOME/.config
setpath $HOME/.local/bin

set config_files (find $HOME/dotfiles -mindepth 2 ! -path "*/fish/*" -type f -name  "*.fish")

for file in $config_files
  source $file
end

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
# for fzf.vim
set -x FZF_DEFAULT_COMMAND fd --type f

# tide
set -g tide_right_prompt_items

# nvm
set -gx NVM_DIR $XDG_CONFIG_HOME/nvm
