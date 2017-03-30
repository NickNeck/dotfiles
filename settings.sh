# Go home
cd $HOME

PROJECTS_DIR=$HOME/Projects

if [ ! -e $PROJECTS_DIR ]
then
  mkdir $PROJECTS_DIR
fi

echo "Setting iTerm preferences"
# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false

echo "Setting macOS preferences"
# Disable smart quotes and dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

echo "Setting Finder preferences"
# Show the ~/Library folder.
chflags nohidden ~/Library

# Show hidden files and file extensions by default
defaults write com.apple.finder AppleShowAllFiles -bool false
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Allow text-selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# New window points to home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

cd $DOTFILES_ROOT
