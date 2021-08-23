#!/usr/bin/env bash

# set -e

echo ""

if [ ! -d $ASDF_DIR ]
then
  echo "set"
fi
DOTFILES_ROOT=$(pwd -P)
BACKUP_DIR=$DOTFILES_ROOT/backup

DEBUG_FLAG=true
DRY_FLAG=true

info () {
  printf "[info ] \e[1;34m%-6s\e[m\n" "$1"
}

debug () {
  if [ $DEBUG_FLAG = true ]
  then
    printf "[debug] %s\n" "$1"
  fi
}

cmd () {
  printf "[cmd  ] %s\n" "$1"
  if [ $DRY_FLAG = false ]
  then
    echo "eval"
    # eval $1
  fi
}

link () {
  local src=$1 dst=$2

  if [ -e $dst ] && [ ! -h $dst ]
  then
    backup $dst
  fi

  if [ -e $dst ]
  then
    linked=$(readlink $dst)
    debug "allready linked: $dst -> $linked"
  else
    debug "link $dst -> $src"
    cmd "ln -s $src $dst"
  fi
}

backup () {
  debug "backup $1"
  cmd "mv $1 $BACKUP_DIR"
}

create_backup_dir () {
  if [ -d $BACKUP_DIR ]
  then
    debug "backup dir $BACKUP_DIR"
  else
    debug "create backup dir $BACKUP_DIR"
    mkdir -p $BACKUP_DIR
  fi
}


install_dotfiles () {
  info "link dotfiles"

  for src in $(find -H "$DOTFILES_ROOT" -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link "$src" "$dst"
  done
}

info "setup dotfiles ..."
debug "DEBUG_FLAG: $DEBUG_FLAG"
debug "DRY_FLAG: $DRY_FLAG"

create_backup_dir
link "$DOTFILES_ROOT/config" "$HOME/.config"
install_dotfiles

case $1 in
  brew | "")
    source install/brew.sh
    ;;
  brew.mas)
    source install/brew.mas.sh
    ;;
  oh-my-zsh | "")
    source install/oh-my-zsh.sh
    ;;
  settings | "")
    source settings/common.sh
    ;;
  asdf | "")
    source settings/asdf.sh
    ;;
esac

info "... ready"
echo ""

