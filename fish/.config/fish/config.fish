set fish_greeting

# neovim
alias vi=nvim
set EDITOR nvim

# homebrew
setpath /opt/homebrew/bin

# tmux
if status is-interactive
and not set -q TMUX
  exec tmux -f ~/.config/tmux/tmux.conf
end

# cargo
setpath ~/.cargo/bin

#python
alias python='/Library/Frameworks/Python.framework/Versions/3.9/bin/python3'
alias pip='/Library/Frameworks/Python.framework/Versions/3.9/bin/pip3'
setpath /Library/Frameworks/Python.framework/Versions/3.9/bin
setpath ~/Library/Python/3.9/bin

# aws-cli
setpath /usr/local/bin

# tide
set -g tide_right_prompt_items

# keybindings
bind \cb backward-word
bind \ct _fzf_search_directory

# fzf
set fzf_fd_opts --hidden --exclude=.git --exclude=node_modules
set fzf_preview_dir_cmd exa --all --color=always
# for fzf.vim
set -x FZF_DEFAULT_COMMAND fd --type f

# nvm.fish
set --universal nvm_default_version lts

# virtualfish
if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
end

# local bin path
setpath $HOME/.local/bin
