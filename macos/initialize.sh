#!/usr/bin/env bash

dir="$(cd "$(dirname $0)";pwd)"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
export PATH:$PATH:/opt/homebrew/bin

brew bundle

"$dir/link.sh"
"$dir/plugin_install_vim.sh"

defaults write -g NSUserKeyEquivalents -dict-add 'Minimize' '\0'
