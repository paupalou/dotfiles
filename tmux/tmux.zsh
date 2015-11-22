#/bin/bash
if [[ -z "$TMUX" ]]; then 
    ID="`tmux ls&>/dev/null | grep -vm1 attached | cut -d: -f1`" # get the id of a deattached session
    if [[ ! -z "$ID" ]] ;then # if not available create a new one
        tmux attach-session -t "$ID" # if available attach to it
    fi
fi
