#!/bin/zsh
set -e

function copy_to() {
    if [ -e $1 ]; then
        echo "copy $1 to here."
        cp $3 $1 $2
    else
        echo "$1 is not found."
    fi
}

copy_to ~/.zshrc .
copy_to ~/.tmux.conf .
copy_to ~/.tmux-pane-border .
copy_to ~/.p10k.zsh .
copy_to ~/.gitconfig .
copy_to ~/.config/nvim .config/ -R
