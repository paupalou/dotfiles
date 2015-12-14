#/bin/bash
source $ZSH/script/colors
# if [[ -z "$TMUX" ]] ;then
#   ID="`tmux ls&>/dev/null | grep -vm1 attached | cut -d: -f1`"
#   if [[ ! -z "$ID" ]] ;then # if there is some deattached session print they
#     echo ''
#     printf "\r   $(pc "TMUX DEATTACHED SESSIONS" $lblue$uline) \n"
#     printf "\r   $(pc "$(tmux list-sessions)" $green)\n"
#     echo ''
#   fi
# fi

local t_resu=$HOME/.tmux/resurrect
local RESULT=$(ls $t_resu | wc -l)
if [ $RESULT -gt 0 ]; then
  printf "\r   $(pc "TMUX DEATTACHED SESSIONS" $lblue$uline) \n"
  for f in $(ls $t_resu/*); do
    printf "\r   $(pc "$(awk 'END{print $2}' $f)" $green)\n"
  done
fi
