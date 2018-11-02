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

alias q="exit"
alias r="ranger"

alias ls="ls -a"
alias vim="nvim"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kyamamoto/bin/google-cloud-sdk/path.fish.inc' ]; . '/Users/kyamamoto/bin/google-cloud-sdk/path.fish.inc'; end

tmux
