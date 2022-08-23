#!/usr/bin/env bash

tmux set prefix None
tmux set key-table off
tmux set status off
tmux set mouse off
tmux if -F '#{pane_in_mode}' 'send-keys -X cancel'
tmux refresh-client -S
