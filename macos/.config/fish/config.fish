set -x ANDROID_HOME $HOME/Library/Android/sdk

set -x KONAN_HOME $HOME/bin/kotlin-native
set -x KONAN_USER_DIR $HOME/.konan
set -x KONAN_DEPS $KONAN_USER_DIR/dependencies

set -x PATH $PATH $HOME/bin/flutter/bin (pyenv root)/shims $ANDROID_HOME/tools/bin $ANDROID_HOME/platform-tools $KONAN_HOME/bin
set -x GOPATH $HOME/Projects/go

source $HOME/.cargo/env

. (pyenv init - | psub)

set -x FZF_DEFAULT_OPTS "--height 20%"

function fish_user_key_bindings
  bind \cr 'h'
end

set -x EDITOR nvim

alias q="exit"
alias r="ranger"

alias ls="ls -a"
alias tmux="tmux -u"
alias vim="nvim"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/bin/google-cloud-sdk/path.fish.inc' ]; . '$HOME/bin/google-cloud-sdk/path.fish.inc'; end


if [ -z $TMUX ];and [ $SHLVL -eq 1 ];tmux attach;or tmux; end

# JetBrains IDEs shortcut
function rubymine
  open -a RubyMine.app $argv
end

function rider
  open -a Rider.app $argv
end

function appcode
  open -a AppCode.app $argv
end

function goland
  open -a GoLand.app $argv
end

function pycharm
  open -a PyCharm.app $argv
end

function webstorm
  open -a WebStorm.app $argv
end

