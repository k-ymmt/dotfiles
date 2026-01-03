#!/usr/bin/env bash

function vim_command {
  vim -u NONE -c "${1}" -c q
}

function git_clone {
  git clone --depth 1 "https://github.com/${1}"
}

function install_gitgutter {
  git_clone "airblade/vim-gitgutter"
  vim_command "helptags vim-gitgutter/doc"
}

function install_airline {
  git_clone "vim-airline/vim-airline"
  vim_command "helptags vim-airline/doc"
}

mkdir -p ~/.vim/pack/dev/start
cd ~/.vim/pack/dev/start

install_gitgutter
install_airline
