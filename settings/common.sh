info "run setting/common.sh"

PROJECTS_DIR=$HOME/Projects

if [ ! -e $PROJECTS_DIR ]
then
  mkdir $PROJECTS_DIR
fi

debug 'setting macOS preferences'
# Disable smart quotes and dashes
cmd 'defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false'
cmd 'defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false'

debug 'setting Finder preferences'
# Show the ~/Library folder.
cmd 'chflags nohidden ~/Library'

# Show hidden files and file extensions by default
cmd 'defaults write com.apple.finder AppleShowAllFiles -bool false'
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Allow text-selection in Quick Look
cmd 'defaults write com.apple.finder QLEnableTextSelection -bool true'

# Disable window animations and Get Info animations
cmd 'defaults write com.apple.finder DisableAllAnimations -bool true'

# Show status bar
cmd 'defaults write com.apple.finder ShowStatusBar -bool true'

# New window points to home
cmd 'defaults write com.apple.finder NewWindowTarget -string "PfHm"'
