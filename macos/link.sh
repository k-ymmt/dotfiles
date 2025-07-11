#!/bin/sh

cd $(dirname $0)

function link_home {
  rm -rf "${HOME}/${1}"

  dir="$(dirname $1)"
  if [ ! -d $dir ];then
    mkdir -p $dir
  fi
  ln -s "$(pwd)/${1}" "${HOME}/${1}"
}

link_home .config
link_home .tmux.conf
link_home .zshrc
link_home .vim
link_home .vimrc
link_home .gitignore_global
link_home .gitconfig
link_home .tigrc
link_home "Library/Application Support/Code/User/keybindings.json"
link_home "Library/Application Support/Code/User/settings.json"
link_home "Library/Developer/Xcode/UserData/FontAndColorThemes/gruvbox.xccolortheme"
