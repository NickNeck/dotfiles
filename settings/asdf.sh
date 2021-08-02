info "run settings/asdf.sh"

ASDF_DIR=$HOME/.asdf

asdf () {
  cmd "asdf plugin add $1"
  cmd "asdf install $1 latest"
  cmd "asdf global $1 latest"
}

if [ -d $ASDF_DIR ]
then
  asdf 'erlang'
  asdf 'elixir'
  asdf 'nodejs'
  asdf 'ruby'
else
  info "asdf is not installed"
fi
