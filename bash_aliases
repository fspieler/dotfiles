#!/bin/bash

# open and source this file :) {
alias vba="\vim ~/.bash_aliases"
alias sb="source ~/.bashrc"
# }

# time ones {
alias make="time make"
# }

# bash utils wrappers {
alias ls="ls --color=auto"
alias ll='ls -hla'
alias sl="ls"
alias rm="trash-put"
alias less='less -NR'
alias nl="nl -nrn -w9"
alias time=awesome_time
alias vim="vim_opener"
alias ivim=vim
alias tmux="tmux -2uS  ~/.tmux.socket"
alias psef="ps -ef | grep"
alias qc="change_ps1 && hist_toggle && clear"
alias sg="srcgrep"
#}

# functions {
mkcd () {
  mkdir -p $1 && cd $1
}

git () {
  if [ $1 == "lol" ] ; then
    command git log --graph --oneline --decorate "${@:2}"
  elif [ $1 == "log" ] ; then
    command git log --name-status "${@:2}"
  elif [ $1 == "qstatus" ] ; then
     command git status -uno
  elif [ $1 == "svn" ] ; then
    if [ $2 == "rebase" ] && [ $# -eq 2 ] ; then
      time git svn rebase
    else
      command git "$@"
    fi
  elif [ $1 == "clone" ] ; then 
    if ! [[ $2 =~ bbgithub.* ]]  ; then
      if [[ $2 =~ devgit.* || $2 =~ github.* ]] ; then
        command git clone "${@:2}"
      else
        echo "No devgit or bbgithub prefix found... defaulting to bbgithub" >&2
        command git clone bbgithub:"${@:2}"
      fi
    else
      command git clone "${@:2}"
    fi
  else
    command git "$@"
  fi
}

cdcat () {
   cd `cat "$@"`
}
#}
