#!/bin/zsh

emulate -LR zsh

set -ue

LAST_FOUND_CMD=""
find_command()
{
  local CMD=$1
  echo " Searching for $CMD"
  if ! LAST_FOUND_CMD=$(command -v $CMD)
  then
    echo " $CMD not found!"
    return 1
  else
    echo " Found $LAST_FOUND_CMD"
    return 0
  fi
}

setup_zsh_config()
{
  echo "Setting up zsh"
  local ZSHRC=$HOME/".zshrc"
  local ZSHENV=$HOME/".zshenv" 

  if [ -f $ZSHRC -o -f $ZSHENV ]
  then
    echo " Found existing zsh config."
    echo " Skipping."
  fi

  if ! find_command zsh
  then
    echo " Aborting!"
    return 1
  fi
}

setup_vim_config()
{
  echo "Setting up vim"
  local VIMRC=$HOME/".vimrc"

  if [ -f $VIMRC ]
  then
    echo " Found existing vim config."
    echo " Skipping."
  fi

  if ! find_command nvim
  then
    echo " Trying vim"
    if ! find_command vim
    then
      echo " Aborting!"
      return 1
    fi
  fi
}

setup_i3_config()
{
  echo "Setting up i3"
  local I3CONFIG=$HOME/".config/i3/config"

  if [ -f $I3CONFIG ]
  then
    echo " Found existing i3 config."
    echo " Skipping."
  fi

  if ! find_command i3
  then
    echo " Aborting!"
    return 1
  fi
}

echo "Starting setup"

if [ ! -d $HOME ]
then
  echo "\$HOME does not point to a existing directory"
  exit 1
fi

setup_zsh_config
setup_vim_config
setup_i3_config
exit 0
