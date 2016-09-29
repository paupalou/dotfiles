# Ag as default source for fzf
# export FZF_DEFAULT_COMMAND='ag -g ""'
# ripgreg as default source for fzf
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
