export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export EDITOR=nvim


HISTFILE=$HOME/.zsh-history
HISTSIZE=10000
SAVEHIST=100000

autoload -Uz colors; colors
autoload -Uz compinit; compinit
autoload -Uz select-word-style; select-word-style bash

PROMPT="
%{${fg[blue]}%}%n%{${reset_color}%}:%{$fg[green]%}%~%{$reset_color%}
>"

setopt auto_pushd
setopt pushd_ignore_dups
setopt auto_param_keys
setopt print_exit_value
setopt mark_dirs
setopt noautoremoveslash
setopt correct
setopt list_packed
setopt complete_in_word
setopt magic_equal_subst
setopt histignorealldups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt hist_verify
setopt hist_save_no_dups
setopt no_flow_control


zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' list-colors "${LS_COLORS}"


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

bindkey '^r' history-incremental-pattern-search-backward
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="> ")
  CURSOR=$#BUFFER
}

function gr() {
  ghq list | fzf --select-1 --exit-0 | read repo_name

  if [ ! $repo_name ];then
    return
  fi

  ghq look $repo_name
}


zle -N select-history
bindkey '^r' select-history

export FZF_DEFAULT_OPTS='--height 20%'

if [ -z $TMUX ] && [ $SHLVL -eq 1 ];then 
  tmux attach || tmux
fi

if [ $(which direnv) ];then
  eval "$(direnv hook zsh)"
fi

alias r='ranger'
alias vim='nvim'
alias q='exit'
alias ls='ls -a'
