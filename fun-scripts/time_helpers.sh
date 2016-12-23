#!/bin/bash

export TIME_OUTPUT_DIR=~/.time.output
function awesome_time () {
  if [ ! -d $TIME_OUTPUT_DIR ] ; then
    rm -i $TIME_OUTPUT_DIR
    mkdir -p $TIME_OUTPUT_DIR
  fi

  TIMESTAMP=$(date +%Y_%m_%d-%H_%M_%S)
  ARGS="$@"

  DIR=${PWD}

  # Note: following uses `which time` to use system time, and avoid infinite recursion

  LOGNAME=$TIME_OUTPUT_DIR/$TIMESTAMP
  echo $@ > $LOGNAME
  echo $DIR >> $LOGNAME
  (`which time` "$@" ) 2>&1 | tee -a $LOGNAME
  STATUS=${PIPESTATUS[0]}
  if [ $STATUS -ne 0 ] ; then
    emphasize -r "Command '$@' finished with non-zero status: $STATUS"
  else
    emphasize -b "Command '$@' finished with zero status"
  fi
  return $STATUS
}

export -f awesome_time

#time log viewer
function tlg () {


  NUMBER=
  MODE=
  if [ $1 == "-n" ] ; then
    NUMBER=$2
    MODE=1
    shift 2
  fi
  COMMAND=$1

  # get all log files, sort by name (which is a timestamp), use head to get first line (the command that was run)
  PIPE=$(find $HOME/.time.output -type f -print0  | sort -nz | xargs -0 -I@ head -vn 1 @ |
  # get filenames that match command
  grep --no-group-separator -B 1 $COMMAND | grep -v $COMMAND |
  # filter filenames that come out of `head`
  sed -e 's@'$TIME_OUTPUT_DIR/'@@g' | sed -e 's/==> //g' | sed -e 's/ <==//g' )

  if [[ $MODE == "" ]] ; then
    echo "$PIPE" | nl
  else
    $EDITOR $TIME_OUTPUT_DIR/$(echo "$PIPE" | sed "${NUMBER}q;d")
  fi
}
