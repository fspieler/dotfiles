#!/bin/bash

echo "This script installs \"fun scripts\" bash prompt. Please make sure you're running this from inside the \`fun-scripts\` directory. If not, please Ctrl+C and try again."

echo "This script depends on your ~/.bashrc running automatically on login. You may want to paste the following in to your ~/.profile if it doesn't:

if [ "$BASH" ]
    then
    echo "Running ~/.bashrc"
    . ~/.bashrc
fi
"

echo "Note that the continued use of the prompt will depend on the exact location of the \`fun-scripts\` directory, so please don't move it! If you do, consider cleaning up your bashrc and rerunning the script."

./emphasize "Which color/prompt profile do you want to use?"
echo "Enter nothing to use default, or enter path name to use different file. If not a real file, a sample will be copied to path location."
read profile_path


if [[ -z "$profile_path" ]] ; then
  if [ -z "$PROMPT_PROFILE_PATH" ] ; then
    echo Using default profile...
    profile_path="$PWD"/fun_scripts_sample_profile
  else
    echo Keep using profile at: $PROMPT_PROFILE_PATH
    profile_path="$PROMPT_PROFILE_PATH"
  fi
elif [[ ! -f $profile_path ]] ; then
  echo Copying sample file to ${profile_path}...
  cp "$PWD"/fun_scripts_sample_profile $profile_path
else
  echo Using $profile_path
fi
profile_path=$(readlink -f $profile_path)

./emphasize "What directory would you like to use for backing up bash history?"
read backup_dir
backup_dir=${backup_dir/~\//$HOME\/}

if [ -z "$backup_dir" ] || [[ "$backup_dir" =~ ^\ +$ ]] ; then
  if [ -z "$BASH_HIST_BAK_DIR" ] ; then
    echo Creating backup directory in current folder
    backup_dir=$PWD/bash_history_backups
  else
    echo "Keep using $BASH_HIST_BAK_DIR"
    backup_dir=$BASH_HIST_BAK_DIR
  fi
elif [ ! -f $backup_dir ] ; then
  if [ ! -d $backup_dir ] ; then
    mkdir -p $backup_dir
    if [[ 0 != $? ]] ; then
      echo Error creating $backup_dir
      exit 1
    fi
  fi
  echo Using $backup_dir
else
  echo "Backup dir is a file :("
  exit 1
fi

./emphasize "Do you want to include this directory in your path? [n]o/[Y]es"
read path_include

prompt_script_path=$PWD/bash_prompt

if [[ -z $path_include ]] || [[ $path_include =~ [yY].* ]] ; then
  echo including fun-scripts on path
  ENABLE_PROMPT="$ENABLE_PROMPT
  export PATH=$PWD:\$PATH"
else
  echo not including fun-scripts on path
fi

ENABLE_PROMPT="  export PROMPT_PROFILE_PATH=$profile_path
  export BASH_HIST_BAK_DIR=$backup_dir
  export ps1_list_index=-1
  source $PWD/bash_prompt"

BEGIN_HEADER="#{ custom bash prompt -- GENERATED - CAN BE DELETED"
END_HEADER="#} end custom bash prompt -- END GENERATED"
cp ~/.bashrc ~/.bashrc.fs.bak
cat ~/.bashrc.fs.bak | tr '\n' '\r' |sed "s/\r#{ custom bash prompt -- GENERATED - CAN BE DELETED.*#} end custom bash prompt -- END GENERATED\r//g" | tr '\r' '\n' > ~/.bashrc

echo "
$BEGIN_HEADER
if [[ -d $backup_dir ]] && [[ -f $prompt_script_path ]] ; then
$ENABLE_PROMPT
fi
$END_HEADER" >> ~/.bashrc

./emphasize "Done! Your old bashrc has been copied to ~/.bashrc.fs.bak. Sourcing bashrc now..."
source ~/.bashrc
