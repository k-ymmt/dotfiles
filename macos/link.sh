#!/bin/sh

cd $(dirname $0)

function link_home {
  ln -s $(pwd)/${1} ${HOME}/${1}
}

link_home .config
link_home .tmux.conf
link_home .vim
link_home .vimrc
link_home .gitignore_global
