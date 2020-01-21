#!/usr/bin/env bash

############################################
# HOMEBREW
############################################

# install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# make sure we’re using the latest homebrew
brew update

# upgrade any already-installed formulae
brew upgrade

# install basics stuff
brew install fish
brew install git

# install other useful things
brew install tree
brew install watchman # to fix jest watch mode
brew install yarn

# enable alternate versions using cask
brew tap homebrew/cask-versions

# install apps
brew cask install 1password6
brew cask install appzapper
brew cask install brave-browser
brew cask install caffeine
brew cask install firefox
brew cask install gfxcardstatus
brew cask install github
brew cask install google-chrome
brew cask install iterm2
brew cask install slack
brew cask install spectacle
brew cask install the-unarchiver
brew cask install visual-studio-code

# install quicklook plugins
brew cask install qlcolorcode # syntax highlighting
brew cask install qlstephen # extension-less text files
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install quicklook-csv

# remove outdated versions from the cellar
brew cleanup


############################################
# CONFIG
############################################

# add fish to the list of acceptable shells (if not already present)
grep -q /usr/local/bin/fish /etc/shells
if [ $? -ne 0 ]; then
	echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
fi

# change current shell to fish
chsh -s /usr/local/bin/fish

# install fisher
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher

# install z
fisher add jethrokuan/z

# install fish-nvm
fisher add jorgebucaran/fish-nvm

# install dracula iterm theme
mkdir -p ~/.config/iterm
curl https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors > ~/.config/iterm/Dracula.itermcolors
open ~/.config/iterm/Dracula.itermcolors

# finally symlink everything
ln -fs "$(pwd)/.editorconfig" ~/.editorconfig
ln -fs "$(pwd)/.gitconfig" ~/.gitconfig
ln -fs "$(pwd)/.gitignore" ~/.gitignore
ln -fs "$(pwd)/.hushlogin" ~/.hushlogin
ln -fs "$(pwd)/config.fish" ~/.config/fish/config.fish
ln -fs "$(pwd)/fish_prompt.fish" ~/.config/fish/functions/fish_prompt.fish
ln -fs "$(pwd)/fish_title.fish" ~/.config/fish/functions/fish_title.fish
ln -fs "$(pwd)/fish_greeting.fish" ~/.config/fish/functions/fish_greeting.fish
