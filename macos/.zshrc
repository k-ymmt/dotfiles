# ===Set Environment Variables===
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim

export ANDROID_HOME=$HOME/Library/Android/sdk
export GOPATH=$HOME/Projects/go

function init() {
  if [ -d $HOME/bin/flutter/bin ];then
    export PATH=$PATH:$HOME/bin/flutter/bin
  fi
  if type pyenv >/dev/null 2>&1 && [ -d $(pyenv root)/shims ];then
    eval "$(pyenv init -)"
    export PATH=$PATH:$(pyenv root)/shims
  fi
  if [ -d $ANDROID_HOME/tools/bin ] && [ -d $ANDROID_HONE/platform-tools ];then
    export PATH=$PATH:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
  fi
  if [ -d $GOPATH/bin ];then
    export PATH=$PATH:$GOPATH/bin
  fi
  if [ -f $HOME/.cargo ];then
    source $HOME/.cargo/env
    export PATH=$PATH:$HOME/.cargo/bin
  fi
  if [ -d $HOME/bin ];then
    PATH=$PATH:$HOME/bin
  fi
  if type direnv >/dev/null 2>&1;then
    eval "$(direnv hook zsh)"
  fi
  if type nodenv >/dev/null 2>&1;then
    eval "$(nodenv init -)"
  fi
  if type rbenv >/dev/null 2>&1; then
    eval "$(rbenv init -)"
    export PATH=$(rbenv root)/shims:$PATH
  fi
  
  export NVM_DIR="$HOME/.nvm"
  if [ -d $NVM_DIR ];then
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  fi

  if type starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
  fi
}

# ===Set History====
HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=100000

setopt histignorealldups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_verify
setopt hist_save_no_dups

function fh() {
  buffer=$( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf --exit-0 --no-sort --query "$LBUFFER" +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')

  BUFFER="$buffer"
  printf '>'
  CURSOR=${#BUFFER}
  zle reset-prompt
}

zle -N fh
bindkey '^r' fh

# ===Set Prompt===
autoload -Uz colors; colors

PROMPT="
%{${fg[blue]}%}%n%{${reset_color}%}:%{$fg[green]%}%~%{$reset_color%}
>"

# ===Set Completion===
autoload -Uz compinit; compinit

setopt complete_in_word

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'


# ===Set Utilities===
autoload -Uz select-word-style; select-word-style bash

setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_param_keys
setopt print_exit_value
setopt mark_dirs
setopt noautoremoveslash
setopt correct
setopt list_packed
setopt magic_equal_subst
setopt no_flow_control

# ===Set Plugins===
if [ ! -d ~/.zplug ];then
  git clone https://github.com/zplug/zplug ~/.zplug
fi

source ~/.zplug/init.zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
      echo; zplug install
  fi
fi

zplug load

export ENHANCD_HOOK_AFTER_CD="ls -a"
export ENHANCD_FILTER=fzf


function gr() {
  ghq list | fzf --select-1 --exit-0 | read repo_name

  if [ ! $repo_name ];then
    return
  fi

  cd "$(ghq root)/$repo_name"
}


export FZF_DEFAULT_OPTS='--height 20%'

if [ -z $TMUX ] && [ $SHLVL -eq 1 ] && [ -n "$TERM_PROGRAM" ]; then 
  tmux attach || tmux
fi

alias r='ranger'
alias vim='nvim'
alias q='exit'
alias ls='ls -a'

init

