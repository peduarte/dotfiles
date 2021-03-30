############################################
# ALIASES
############################################

# shortcuts
alias dt "cd ~/Desktop"
alias dl "cd ~/Downloads"
alias s "cd ~/Sites"

# listings
alias l "ls -laF"

# git
alias gs "git status -s"
alias ga "git add"
alias gc "git commit"

# enable aliases to be sudo’ed
alias sudo "sudo "

# show/hide hidden files in Finder
alias show "defaults write com.apple.finder AppleShowAllFiles -bool true and killall Finder"
alias hide "defaults write com.apple.finder AppleShowAllFiles -bool false and killall Finder"

# show/hide desktop (useful when presenting)
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true and killall Finder"
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false and killall Finder"

# list all "node_modules" folders in current directory
alias lsnm="find . -name 'node_modules' -type d -prune -print | xargs du -chs"

# delete all "node_modules" folders in current directory
alias rmnm="find . -name 'node_modules' -type d -prune -print -exec rm -rf '{}' \;"

############################################
# FUNCTIONS
############################################

# create a new directory and cd into it
function mkd
    mkdir -p $argv
    and cd $argv
end
