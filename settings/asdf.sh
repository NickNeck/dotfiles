info "run settings/asdf.sh"

setup_asdf () {
  cmd "asdf plugin add $1"
  cmd "asdf install $1 latest"
  cmd "asdf global $1 latest"
}

setup_asdf 'erlang'
setup_asdf 'elixir'
setup_asdf 'nodejs'
setup_asdf 'ruby'
