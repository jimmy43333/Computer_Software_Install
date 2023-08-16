#!/bin/bash

# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# eval "$(/opt/homebrew/bin/brew shellenv)"
brew help

# install nodejs
brew install node
brew install zsh-completions
compaudit | xargs chmod g-w

# zsh
# oh my zsh 
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# syntax-hightlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install font
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
# brew cask search nerd

# powerlevel10
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# ZSH_THEME="powerlevel10k/powerlevel10k"
p10k configure