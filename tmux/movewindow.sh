#!/bin/bash

# 1. capture the id of the src window and current index
src_id=$(tmux display-message -p '#{window_id}')
src_index=$(tmux display-message -p '#I')
dest_index=$1

# sanity check: if start and end are the same, do nothing
if [ "$src_index" -eq "$dest_index" ]; then
    exit 0
fi

# 2. move the source window to a temporary holding area (9999)
tmux move-window -d -s "$src_index" -t 9999

# 3. shift other windows to fill the gap or make room
if [ "$src_index" -lt "$dest_index" ]; then
    # shift windows between (src+1) and dest to the left
    for i in $(seq $((src_index + 1)) "$dest_index"); do
        tmux move-window -d -s "$i" -t $((i - 1))
    done
else
    # shift windows between (src-1) and dest to the right
    # note: using tac or specific seq logic for reverse order
    for i in $(seq $((src_index - 1)) -1 "$dest_index"); do
        tmux move-window -d -s "$i" -t $((i + 1))
    done
fi

# 4. place our window at the destination
tmux move-window -d -s 9999 -t "$dest_index"

# 5. renumber windows sequentially to remove any gaps
base=$(tmux show-option -gqv base-index)
[ -z "$base" ] && base=0
counter=$base

tmux list-windows -F "#{window_id}" | while read -r wid; do
    cur=$(tmux display-message -p -t "$wid" '#I')
    if [ "$cur" -ne "$counter" ]; then
        tmux move-window -d -s "$wid" -t "$counter"
    fi
    ((counter++))
done

# 6. ensure we are still looking at the window we moved
tmux select-window -t "$src_id"
