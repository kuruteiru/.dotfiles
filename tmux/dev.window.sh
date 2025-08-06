# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
window_root "."

# Create new window. If no argument is given, window name will be based on
# layout file name.

current_window=$(__get_current_window_index)

if [ -f ./todo.* ]; then
	new_window "todo"
	run_cmd "nvim todo.*"
fi

new_window "nvim"
if [ -f ./main.* ]; then
	run_cmd "nvim main.*"
else
	run_cmd "nvim"
fi
new_window "bash"

select_window $(expr "$current_window" + 1)

tmux kill-window -t "$current_window"

# Split window into panes.
#split_v 20
#split_h 50

# Run commands.
#run_cmd "top"     # runs in active pane
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
#select_pane 0
