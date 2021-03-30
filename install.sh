#!/usr/bin/env bash

############################################
# HOMEBREW
############################################

# install homebrew
if ! which brew > /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# make sure we’re using the latest homebrew
brew update

# upgrade any already-installed formulae
brew upgrade

# install basics stuff
brew install fish
brew install git
brew install gh
brew install watchman


# install other useful things
brew install tree
brew install watchman # to fix jest watch mode
brew install yarn

# enable alternate versions using cask
brew tap homebrew/cask-versions

# enable installing drivers using cask
brew tap homebrew/cask-drivers

# install apps
brew install --cask 1password
brew install --cask brave-browser
brew install --cask github
brew install --cask iterm2
brew install --cask visual-studio-code
brew install --cask alfred
brew install --cask spotify
brew install --cask finicky
brew install --cask slack
brew install --cask discord
brew install --cask figma
brew install --cask cleanshot
brew install --cask rectangle
brew install --cask zoom

# install drivers
brew install --cask logitech-options

# install fonts
brew tap homebrew/cask-fonts
brew cask install font-iosevka
brew cask install font-inter

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
fisher install jethrokuan/z

# install fish-nvm
fisher install jorgebucaran/fish-nvm

# install dracula iterm theme
mkdir -p ~/.config/iterm
curl https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors > ~/.config/iterm/Dracula.itermcolors
open ~/.config/iterm/Dracula.itermcolors

# install dracula fish color mapping
curl https://raw.githubusercontent.com/dracula/fish/master/conf.d/dracula.fish > ~/.config/fish/conf.d/dracula.fish

# finally symlink everything
ln -fs "$(pwd)/.editorconfig" ~/.editorconfig
ln -fs "$(pwd)/.gitconfig" ~/.gitconfig
ln -fs "$(pwd)/.gitignore" ~/.gitignore
ln -fs "$(pwd)/.hushlogin" ~/.hushlogin
ln -fs "$(pwd)/config.fish" ~/.config/fish/config.fish
ln -fs "$(pwd)/fish_prompt.fish" ~/.config/fish/functions/fish_prompt.fish
ln -fs "$(pwd)/fish_title.fish" ~/.config/fish/functions/fish_title.fish
ln -fs "$(pwd)/fish_greeting.fish" ~/.config/fish/functions/fish_greeting.fish
