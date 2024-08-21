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
set -x FZF_DEFAULT_OPTS --color=bg+:#E6E9EF,fg+:#4C4F69
set -x FZF_DEFAULT_COMMAND fd --type f
set -x LS_COLORS ""

# tide
set -g tide_right_prompt_frame_enabled true
set -g tide_right_prompt_items python
set -g tide_git_color_branch 49A600

# paths
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.deno/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.local/kitty.app/bin
