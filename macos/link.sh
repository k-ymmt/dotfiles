#!/bin/sh

cd $(dirname $0)

function link_home {
  rm -rf "${HOME}/${1}"
  ln -s "$(pwd)/${1}" "${HOME}/${1}"
}

link_home .config
link_home .tmux.conf
link_home .zshrc
link_home .vim
link_home .vimrc
link_home .gitignore_global
link_home .tigrc
link_home "Library/Application Support/Code/User/keybindings.json"
link_home "Library/Application Support/Code/User/settings.json"
