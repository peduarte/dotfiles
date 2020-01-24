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

# enable installing drivers using cask
brew tap homebrew/cask-drivers

# install apps
brew cask install brave-browser
brew cask install browserosaurus
brew cask install firefox
brew cask install gfxcardstatus
brew cask install github
brew cask install google-chrome
brew cask install iterm2
brew cask install visual-studio-code
brew cask install alfred
brew cask install spotify
brew cask install caffeine

# install drivers
brew cask install logitech-options

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

# install dracula fish color mapping
curl https://raw.githubusercontent.com/dracula/fish/master/dracula.fish > ~/.config/fish/conf.d/dracula.fish

# finally symlink everything
ln -fs "$(pwd)/.editorconfig" ~/.editorconfig
ln -fs "$(pwd)/.gitconfig" ~/.gitconfig
ln -fs "$(pwd)/.gitignore" ~/.gitignore
ln -fs "$(pwd)/.hushlogin" ~/.hushlogin
ln -fs "$(pwd)/config.fish" ~/.config/fish/config.fish
ln -fs "$(pwd)/fish_prompt.fish" ~/.config/fish/functions/fish_prompt.fish
ln -fs "$(pwd)/fish_title.fish" ~/.config/fish/functions/fish_title.fish
ln -fs "$(pwd)/fish_greeting.fish" ~/.config/fish/functions/fish_greeting.fish
