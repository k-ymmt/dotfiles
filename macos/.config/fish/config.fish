function set_env
  set -x ANDROID_HOME $HOME/Library/Android/sdk
  set -x KONAN_HOME $HOME/bin/kotlin-native
  set -x KONAN_USER_DIR $HOME/.konan
  set -x KONAN_DEPS $KONAN_USER_DIR/dependencies
  set -x GOPATH $HOME/Projects/go
  if [ -d $HOME/bin/flutter/bin ]
    set -x PATH $PATH $HOME/bin/flutter/bin 
  end

  if [ (which pyenv) ] && [ -d (pyenv root)/shims ]
    . (pyenv init - | psub)
    set -x PATH $PATH (pyenv root)/shims
  end
  if [ -d $ANDROID_HOME/tools/bin ] && [ -d $ANDROID_HOME/platform-tools ]
    set -x PATH $PATH $ANDROID_HOME/tools/bin
    set -x PATH $PATH $ANDROID_HOME/platform-tools
  end
  if [ -d $KONAN_HOME/bin ]
    set -x PATH $PATH $KONAN_HOME/bin
  end
  if [ -d $GOPATH/bin ]
    set -x PATH $PATH $GOPATH/bin
  end
  if [ -d $HOME/.cargo/env ]
    source $HOME/.cargo/env
  end
  if [ (which direnv) ]
    eval (direnv hook fish)
  end
  if [ (which starship) ]
    starship init fish | source
  end
end


set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

set -x FZF_DEFAULT_OPTS "--height 20%"

function fish_user_key_bindings
  bind \cr 'h'
end

set -x EDITOR nvim

set_env

alias q="exit"
alias r="ranger"

alias ls="ls -a"
alias tmux="tmux -u"
alias vim="nvim"
alias lg="lazygit"

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

