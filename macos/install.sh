#!/usr/bin/env bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

brew install \
  ranger \
  ghq \
  tmux \
  direnv \
  neovim \
  jesseduffield/lazygit/lazygit
