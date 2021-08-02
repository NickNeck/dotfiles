info 'run install/oh-my-zsh.sh'

OH_MY_ZSH_DIR=$HOME/.oh-my-zsh

if [ -d $OH_MY_ZSH_DIR ]
then
  debug 'oh-my-zsh already installed'
else
  info 'install oh-my-zsh'
  cmd 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc'
  debug 'link oh-my-zsh custom'
  link "$DOTFILES_ROOT/oh-my-zsh" "$OH_MY_ZSH_DIR/custom"
fi
