#!/usr/bin/env bash

tmux set -u prefix
tmux set -u key-table
tmux set -g status on
tmux refresh-client -S
