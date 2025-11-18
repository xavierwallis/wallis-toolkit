#!/bin/zsh

set -euo pipefail
echo "Hi xavier :)"

# centering
cd

echo "downloading xcode-tools"

if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install || true
else
    echo "Xcode tools already installed"
fi

echo "downloading homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

brew update



echo "downloading uv python"
curl -LsSf https://astral.sh/uv/install.sh | sh

echo "downloading formulae"
# Formulae
brew install \
    neofetch \
    yabai \
    ffmpeg \
    docker \
    docker-completion \
    docker-compose \
    supabase \
    stripe-cli \
    mas \
    rustup \
    fzf \
    dotenvx \
    thefuck \
    lua \
    tailscale

echo "downloading casks"
brew install --cask \
    adobe-creative-cloud \
    blender \
    raycast \
    via \
    vivid \
    chromedriver \
    yabai \
    dotnet-sdk \
    notion \
    numi \
    fantastical \
    jetbrains-toolbox \
    ollama \
    tempbox \
    npm \
    whisky \
    fish \
    starship \
    fzf \
    tmux \
    yaak \


echo "downloading mac apps"
mas install \
# Xcode
  497799835  \
# nextdns
  1464122853 \
# hidden-bar
  1452453066 \
# flow
  1423210932 \
# amphetamine
  937984704  \
# excel
  462058435  \
# word
  462054704  \
# powerpoint
  462062816  \
# tailscale
  1475387142


# disregard
npm install webtorrent-cli -g


echo "unviersity dir"
mkdir ~/university


cp ./.yabairc ~/.yabairc
echo "built yabairc"

cp ./.zshrc ~/.zshrc


if [ ! -d ".config" ]; then mkdir ".config" fi

cp -r ./nvim ~/.config/nvim

cp ./tmux.conf ~/.config/tmux.conf
cp -r ./alacritty ~/.config/alacritty

echo "building fish config file"
if [ ! -d ".config/fish" ]; then mkdir ".config/fish" fi

cp ./fish/config.fish ~/.config/fish/config.fish

source ~/.zshrc

tailscale login
