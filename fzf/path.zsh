# ripgreg as default source for fzf
export FZF_DEFAULT_COMMAND='rg -i --files --no-ignore --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
