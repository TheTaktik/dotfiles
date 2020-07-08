#!/bin/zsh

emulate -LR zsh

set -ue

# see https://stackoverflow.com/questions/4774054/reliable-way-for-a-bash-script-to-get-the-full-path-to-itself/4774063
SCRIPTDIR="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
SCRIPTPATH=$SCRIPTDIR/"setup.sh"

FORCE=0

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

link_config()
{
  local SRC=$1
  local DEST=$2

  if [ -f $DEST ]
  then
    echo " Found existing $DEST."
    if [ $FORCE -eq 0 ]
    then
      echo " Skipping."
      return 0
    else
      local BACKUP=$BACKUP_DIR/"$(basename $DEST)"
      echo " Creating backup $BACKUP"
      cp $DEST $BACKUP
    fi
  fi

  if ! [ -f $SRC ]
  then
    echo " Install file $SRC not found"
    echo " Aborting."
    return 1
  fi

  echo " Linking $DEST"
  ln -sf $SRC $DEST
}

setup_zsh_config()
{
  echo "Setting up zsh"
  local ZSHRC=$HOME/".zshrc"
  local ZSHENV=$HOME/".zshenv" 
  local ZSHRC_SRC=$SCRIPTDIR/".zshrc"
  local ZSHENV_SRC=$SCRIPTDIR/".zshenv" 
  if ! find_command zsh
  then
    echo " Aborting!"
    return 1
  fi
  link_config $ZSHRC_SRC $ZSHRC
  link_config $ZSHENV_SRC $ZSHENV
}

setup_vim_config()
{
  echo "Setting up vim"
  local VIMRC=$HOME/".vimrc"
  local VIMRC_SRC=$SCRIPTDIR/".vimrc"
  if ! find_command nvim
  then
    echo " Trying vim"
    if ! find_command vim
    then
      echo " Aborting!"
      return 1
    fi
  fi
  link_config $VIMRC_SRC $VIMRC
}

setup_i3_config()
{
  echo "Setting up i3"
  local I3CONFIG=$HOME/".config/i3/config"
  local I3CONFIG_SRC=$SCRIPTDIR/"i3config"
  if ! find_command i3
  then
    echo " Aborting!"
    return 1
  fi
  link_config $I3CONFIG_SRC $I3CONFIG
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

if [ $# -ge 1 ] && [ $1 = "force" ]
then
  FORCE=1
fi

BACKUP_DIR=$HOME/".tt_setup_backup"
echo "Creating backup dir $BACKUP_DIR"
mkdir -p $BACKUP_DIR

setup_zsh_config
setup_vim_config
setup_i3_config
exit 0
