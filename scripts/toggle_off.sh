#!/usr/bin/env bash

tmux set -u prefix
tmux set -u key-table
tmux set status on
tmux set mouse on
tmux refresh-client -S
