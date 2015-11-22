#/bin/bash
source $ZSH/script/colors
if [[ -z "$TMUX" ]] ;then
    ID="`tmux ls&>/dev/null | grep -vm1 attached | cut -d: -f1`"
    if [[ ! -z "$ID" ]] ;then # if there is some deattached session print they
        echo ''
        printf "\r   $(pc "TMUX DEATTACHED SESSIONS" $lblue$uline) \n"
        printf "\r   $(pc "$(tmux list-sessions)" $green)\n"
        echo ''
    fi
fi
