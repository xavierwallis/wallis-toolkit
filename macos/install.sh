#!/bin/zsh
echo "Hi xavier :)"

# centering
cd

echo "downloading xcode-tools"
xcode-select --install

echo "downloading homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

source ~/.zprofile

brew update


echo "downloading formulae"
# Formulae
brew install neofetch yabai ffmpeg docker docker-completion docker-compose python@3.12 supabase stripe-cli mas rustup fzf dotenvx thefuck lua


echo "downloading casks"
# Casks
brew install --cask adobe-creative-cloud blender raycast via vivid chromedriver yabai dotnet-sdk notion numi fantastical jetbrains-toolbox ollama bruno tempbox npm whisky fish starship fzf neovim tmux webstorm dataspell


echo "downloading mac apps"
# Mac Apps  Xcode     nextdns    hidden-bar flow     amphetamine excel     word     powerpoint tailscale
mas install 497799835 1464122853 1452453066 1423210932 937984704 462058435 462054704 462062816 1475387142


# disregard
npm install webtorrent-cli -g


echo "unviersity dir"
mkdir ~/university


mv ./.yabairc ~/.yabairc
echo "built yabairc"

echo "building fish config file"
if [ ! -d ".config" ]; then mkdir ".config" fi
if [ ! -d ".config/fish" ]; then mkdir ".config/fish" fi
echo "starship init fish | source" > ~/.config/fish/config.fish

echo "zoxide init fish | source" >> ~/.config/fish/config.fish

echo "tmux" > .zshrc
echo "fish" >> .zshrc

source ~/.zshrc
