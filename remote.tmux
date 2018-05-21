#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/helpers.sh"

main() {
	if option_not_exists $toggle_key_option $default_toggle_key; then
		tmux set-option -g $toggle_key_option $default_toggle_key
	fi
	if option_not_exists $on_key_option $default_on_key; then
		tmux set-option -g $on_key_option $default_on_key
	fi
	if option_not_exists $off_key_option $default_off_key; then
		tmux set-option -g $off_key_option $default_off_key
	fi

	local toggle_key=$(tmux show-option -gv "$toggle_key_option")
	local on_key=$(tmux show-option -gv "$on_key_option")
	local off_key=$(tmux show-option -gv "$off_key_option")

	tmux unbind -T root $toggle_key
	tmux unbind -T off $toggle_key
	tmux unbind -T root $on_key
	tmux unbind -T off $on_key
	tmux unbind -T root $off_key
	tmux unbind -T off $off_key

	# Press the toggle key to toggle "remote mode"; disables host bindings for
	# using tmux in nested sessions
	tmux bind -T root $toggle_key \
		run-shell "$CURRENT_DIR/scripts/toggle_on.sh"
	tmux bind -T off $toggle_key \
		run-shell "$CURRENT_DIR/scripts/toggle_off.sh"

	tmux bind -T root $on_key \
		run-shell "$CURRENT_DIR/scripts/toggle_on.sh"
	tmux bind -T off $on_key \
		run-shell "$CURRENT_DIR/scripts/toggle_on.sh"

	tmux bind -T root $off_key \
		run-shell "$CURRENT_DIR/scripts/toggle_off.sh"
	tmux bind -T off $off_key \
		run-shell "$CURRENT_DIR/scripts/toggle_off.sh"
}

main
