#!/usr/bin/env bash
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/ws -mindepth 1 -maxdepth 2 -type d -not -path "*.git" | fzf)
    is_existing_workspace=true
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s ws -n $selected_name -c $selected
    tmux send-keys -t $selected_name "l" C-m
    exit 0
fi

if tmux list-windows | grep -q $selected_name; then
    tmux select-window -t $selected_name
    tmux send-keys -t $selected_name "cd $selected" C-m
else
    tmux new-window -n $selected_name -c $selected 
fi

if [ "$is_existing_workspace" = true ] ; then
    tmux send-keys -t $selected_name "l" C-m
fi

exit 0