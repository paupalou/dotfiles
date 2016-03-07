# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -f -g ""'

# v - open files in ~/.viminfo
v() {
  local files
  files=$(grep '^>' ~/.viminfo | cut -c3- |
  while read line; do
    [ -f "${line/\~/$HOME}" ] && echo "$line"
  done | fzf-tmux -d -m -q "$*" -1) && vim ${files//\~/$HOME}
}
