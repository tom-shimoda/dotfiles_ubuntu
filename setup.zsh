#!/usr/bin/zsh
set -e

# nvm
source ~/.nvm/nvm.sh
nvm install --lts --latest-npm

# pyenv
# python3_version=$(pyenv install -l | grep -v '[a-zA-Z]' | grep -e '\s3\.?*' | tail -1 | sed 's/^[[:blank:]]*//')
# pyenv install $python3_version
# pyenv global $python3_version
# pyenv rehash
