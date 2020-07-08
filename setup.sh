#!/bin/zsh

emulate -LR zsh

set -ue

# see https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself/4774063
SCRIPTDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SCRIPTPATH=$SCRIPTDIR/"setup.sh"

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
    return 0
  fi

  if ! find_command zsh
  then
    echo " Aborting!"
    return 1
  fi

  local ZSHRC_SRC=$SCRIPTDIR/".zshrc"
  local ZSHENV_SRC=$SCRIPTDIR/".zshenv" 

  if ! [ -f $ZSHRC_SRC -a -f $ZSHENV_SRC ]
  then
    echo " Install files not found"
    echo " Aborting."
    return 1
  fi

  ln -sf $ZSHRC_SRC $ZSHRC
  ln -sf $ZSHENV_SRC $ZSHENV
}

setup_vim_config()
{
  echo "Setting up vim"
  local VIMRC=$HOME/".vimrc"

  if [ -f $VIMRC ]
  then
    echo " Found existing vim config."
    echo " Skipping."
    return 0
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

  local VIMRC_SRC=$SCRIPTDIR/".vimrc"

  if ! [ -f $VIMRC_SRC ]
  then
    echo " Install files not found"
    echo " Aborting."
    return 1
  fi

  ln -sf $VIMRC_SRC $VIMRC
}

setup_i3_config()
{
  echo "Setting up i3"
  local I3CONFIG=$HOME/".config/i3/config"

  if [ -f $I3CONFIG ]
  then
    echo " Found existing i3 config."
    echo " Skipping."
    return 0
  fi

  if ! find_command i3
  then
    echo " Aborting!"
    return 1
  fi

  local I3CONFIG_SRC=$SCRIPTDIR/"i3config"

  if ! [ -f $I3CONFIG_SRC ]
  then
    echo " Install files not found"
    echo " Aborting."
    return 1
  fi

  ln -sf $I3CONFIG_SRC $I3CONFIG
}

echo "Starting setup"

if [ ! -f $SCRIPTPATH ]
then
  echo "$SCRIPTPATH does not point to this script!"
  echo "Aborting!"
  exit 1
fi

if [ ! -d $HOME ]
then
  echo "\$HOME does not point to a existing directory"
  echo "Aborting!"
  exit 1
fi

setup_zsh_config
setup_vim_config
setup_i3_config
exit 0
