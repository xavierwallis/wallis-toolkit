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
    tailscale \
    tree \
    vite \
    go \
    fzf \
    r \
    dotnet \
    tesseract \
    streamlink \
    starship


echo "downloading casks"
brew install --cask \
    arc \
    blender \
    chromedriver \
    docker-desktop \
    dotnet-sdk \
    firefox \
    fish \
    font-sf-mono-nerd-font \
    fzf \
    love \
    mactex \
    minecraft \
    modrinth \
    notion \
    npm \
    numi \
    obs \
    ollama \
    raycast \
    starship \
    spotify \
    tempbox \
    tmux \
    tor-browser \
    via \
    vivid \
    vivid-app \
    whisky \
    yaak \
    yabai


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
  1475387142 \
# klack
  6446206067 


echo "visit https://gumroad.com/d/cc722b08fcb21e757f737b90f9db0f15 for dynamic lake omegalul"

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

echo "installing c/++ toolkits"

sudo cp ~/projects/wallis-toolkit/language/c/toolkit.h /usr/local/include/toolkit.h
sudo cp ~/projects/wallis-toolkit/language/c++/toolkit.h /usr/local/include/toolkit_cpp.h

cc -c ~/projects/wallis-toolkit/language/c/toolkit.c -o toolkit.o
ar rcs libtoolkit.a toolkit.o
sudo cp libtoolkit.a /usr/local/lib/


echo "installing go toolkit"

mkdir -p ~/projects/go/src/toolkit
cp ~/projects/wallis-toolkit/language/go/toolkit.go ~/projects/go/src/toolkit/toolkit.go

echo "installing python toolkit"

PY_SITE=$(python3 - <<'EOF'
import site; print(site.getsitepackages()[0])
EOF
)

sudo mkdir -p "$PY_SITE/toolkit"
sudo cp ~/projects/wallis-toolkit/language/python/__init__.py "$PY_SITE/toolkit/__init__.py"

echo "installing rust toolkit"

mkdir -p ~/.cargo/toolkit/src
cp ~/projects/wallis-toolkit/language/rust/*.rs ~/.cargo/toolkit/src/

cat <<EOF > ~/.cargo/toolkit/Cargo.toml
[package]
name = "toolkit"
version = "0.1.0"
edition = "2021"

[lib]
path = "src/toolkit.rs"
EOF

cargo install --path ~/.cargo/toolkit


echo "installing typescript toolkit"

mkdir -p ~/projects/typescript/toolkit
cp ~/projects/wallis-toolkit/language/typescript/*.ts ~/projects/typescript/toolkit

cat <<EOF > ~/projects/typescript/toolkit/package.json
{
  "name": "toolkit",
  "version": "1.0.0",
  "type": "module",
  "main": "main.ts"
}
EOF

npm install -g ~/projects/typescript/toolkit
