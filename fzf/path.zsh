# ripgreg as default source for fzf
export FZF_DEFAULT_COMMAND='rg -i --files --no-ignore --follow --glob "!.git/*" --glob "!node_modules/*" '
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
