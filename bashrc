#!/bin/bash

# { aliases
source ~/.bash_aliases
# } end aliases

# { set custom env variables
export TEST_ARGS="--bael-log-on-success --baem-metrics --gtest_shuffle"
# }

# { set path
# if ~/bin not at start of path, add it/move it
if [[ $PATH != $HOME/bin* ]] ; then
  echo "Adding ~/bin to path"
  export PATH=$HOME/bin:${PATH//$HOME\/bin/}
fi
# } end path

# { ls colors

# foreground prefix
FPREF="38;5"
# background prefix
BPREF="48;5"
LS_DIR="di=$FPREF;213"
LS_LINK="ln=$FPREF;81"
LS_PIPE="pi=$FPREF;196"
LS_EXE="ex=$FPREF;88"
LS_SOCKET="so=$FPREF;164"
LS_SOURCE_FILE="$BPREF;16" # black backround
LS_OBJECT_FILE="$BPREF;238"
LS_CPP="*.cpp=$LS_SOURCE_FILE"
LS_C="*.c=$LS_SOURCE_FILE"
LS_H="*.h=$LS_SOURCE_FILE"
LS_PY="*.py=$LS_SOURCE_FILE"
LS_D="*.d=$LS_OBJECT_FILE"
LS_DD="*.dd=$LS_OBJECT_FILE"
LS_O="*.o=$LS_OBJECT_FILE"
export LS_COLORS=$LS_DIR:$LS_LINK:$LS_PIPE:$LS_EXE:$LS_SOCKET:$LS_CPP:$LS_H:$LS_C:$LS_PY:$LS_D:$LS_DD:$LS_O

# } end ls colors

# { vim-ness
set -o vi
export EDITOR=vim
#}

# { shopts
shopt -s autocd #typing dir name will cd to that dir
shopt -s cdable_vars #can cd directly to variable names
shopt -s cdspell #minor spell checking for cd
shopt -s checkjobs #warn about stopped and bg jobs before closing shell
shopt -s histappend #append to hist file
shopt -s histverify #don't immediately run history substitutions
# } et al.

#{ custom bash prompt -- GENERATED - CAN BE DELETED
if [[ -d /home/fred/.bash_history_backups ]] && [[ -f /home/fred/dotfiles/fun-scripts/bash_prompt ]] ; then
  export PATH=/home/fred/dotfiles/fun-scripts:$PATH
  export PROMPT_PROFILE_PATH=/home/fred/dotfiles/color_profile
  export BASH_HIST_BAK_DIR=/home/fred/.bash_history_backups
  export ps1_list_index=-1
  source /home/fred/dotfiles/fun-scripts/bash_prompt
fi
#} end custom bash prompt -- END GENERATED

 patriotismbot
