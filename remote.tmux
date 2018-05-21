#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/helpers.sh"

main() {
	if option_value_not_changed $toggle_key_option $default_toggle_key; then
		tmux set-option -g $toggle_key_option $default_toggle_key
	fi

	local key=$(tmux show-option -gv "$toggle_key_option")

	wg_is_remote="#[fg=$color_light,bg=$color_window_off_indicator]#([ $(tmux show-option -qv key-table) = 'off' ] && echo '[OFF]')#[default]"
	tmux set -g status-left "$wg_is_remote"

	tmux unbind -T root $key
	tmux unbind -T off $key

	# Press the toggle key to toggle "remote mode"; disables host bindings for
	# using tmux in nested sessions
	tmux bind -T root $key \
		run-shell "$CURRENT_DIR/scripts/toggle_on.sh" \;\

	tmux bind -T off $key \
		run-shell "$CURRENT_DIR/scripts/toggle_off.sh" \;\

}

main
