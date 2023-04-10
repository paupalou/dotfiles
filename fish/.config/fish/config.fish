set fish_pager_color_progress brblack --background=brmagenta
set fish_greeting

# tmux
if status is-interactive
and not set -q TMUX
  exec tmux -f ~/.config/tmux/tmux.conf
  exit
end

# nvim
alias vi=nvim
set -gx EDITOR nvim

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

# paths
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.deno/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/kitty.app/bin
