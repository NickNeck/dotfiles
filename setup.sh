#!/usr/bin/env bash

# set -e

echo ""

DOTFILES_ROOT=$(pwd -P)
BACKUP_DIR=$DOTFILES_ROOT/backup

DEBUG_FLAG=true

info () {
  printf "[info ] \e[1;34m%-6s\e[m\n" "$1"
}

debug () {
  if [ DEBUG_FLAG = true ]
  then
    printf "[debug] %s\n" "$1"
  fi
}

cmd () {
  printf "[cmd  ] %s\n" "$1"
  eval $1
}

install_dotfiles () {
  info "link dotfiles"

  for src in $(find -H "$DOTFILES_ROOT" -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link "$src" "$dst"
  done
}

link () {
  local src=$1 dst=$2

  if [ -e $dst ] && [ ! -h $dst ]
  then
    backup $dst
  fi

  if [ -e $dst ]
  then
    debug "allready linked: $dst -> $src"
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
  if [ ! -d $BACKUP_DIR ]
  then
    mkdir -p $BACKUP_DIR
  fi
}

info "setup dotfiles ..."

create_backup_dir
install_dotfiles

info "... ready"
echo ""

