#!/bin/zsh

set -euo pipefail
echo 'Hi xavier :)'

# resolve repo paths before any cd so the copy steps never break
script_directory=${0:A:h}
toolkit_directory=${script_directory:h}

# centering
cd

echo 'downloading xcode-tools'

if ! xcode-select -p >/dev/null 2>&1; then
    xcode-select --install || true
else
    echo 'Xcode tools already installed'
fi

echo 'downloading homebrew'
/bin/bash -c "$( curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh )"
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> ~/.zprofile
eval "$( /opt/homebrew/bin/brew shellenv )"

brew update

echo 'downloading uv python'
curl -LsSf https://astral.sh/uv/install.sh | sh

echo 'downloading formulae'
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
    r \
    dotnet \
    tesseract \
    streamlink \
    starship \
    fish \
    tmux \
    neovim \
    node \
    fisher


echo 'downloading casks'
brew install --cask \
    arc \
    blender \
    chromedriver \
    claude-code \
    codex \
    docker-desktop \
    dotnet-sdk \
    firefox \
    font-sf-mono-nerd-font \
    ivpn \
    love \
    mactex \
    minecraft \
    modrinth \
    notion \
    numi \
    obs \
    ollama \
    raycast \
    spotify \
    tempbox \
    tor-browser \
    via \
    vivid \
    vivid-app \
    whisky \
    yaak


echo 'downloading mac apps'
mas install 497799835  || echo 'mas failed: xcode (signed into the app store?)'
mas install 1452453066 || echo 'mas failed: hidden-bar'
mas install 1423210932 || echo 'mas failed: flow'
mas install 937984704  || echo 'mas failed: amphetamine'
mas install 462062816  || echo 'mas failed: powerpoint'
mas install 1475387142 || echo 'mas failed: tailscale'
mas install 6446206067 || echo 'mas failed: klack'


echo 'visit https://gumroad.com/d/cc722b08fcb21e757f737b90f9db0f15 for dynamic lake omegalul'

# disregard
npm install webtorrent-cli -g


cp "$script_directory/.yabairc" ~/.yabairc
chmod +x ~/.yabairc
yabai --start-service || echo 'yabai needs accessibility permissions, start it manually after granting them'
echo 'built yabairc'

cp "$script_directory/.zshrc" ~/.zshrc


mkdir -p ~/.config

rm -rf ~/.config/nvim
cp -R "$script_directory/nvim" ~/.config/nvim

cp "$script_directory/tmux.conf" ~/.config/tmux.conf

rm -rf ~/.config/alacritty
cp -R "$script_directory/alacritty" ~/.config/alacritty

mkdir -p ~/.config/git
cp "$script_directory/git/ignore" ~/.config/git/ignore

echo 'building fish config'
rm -rf ~/.config/fish
mkdir -p ~/.config/fish
cp "$script_directory/fish/config.fish" ~/.config/fish/config.fish
cp "$script_directory/fish/fish_plugins" ~/.config/fish/fish_plugins
cp -R "$script_directory/fish/functions" ~/.config/fish/functions

echo 'installing fish plugins'
fish -c 'fisher update' || echo 'fisher update failed, run it manually'

source ~/.zshrc || true

tailscale login || echo 'tailscale login skipped, run it manually'

echo 'installing c/++ toolkits'

sudo mkdir -p /usr/local/include /usr/local/lib
sudo cp "$toolkit_directory/language/c/toolkit.h" /usr/local/include/toolkit.h
sudo cp "$toolkit_directory/language/c++/toolkit.h" /usr/local/include/toolkit_cpp.h

build_directory=$( mktemp -d )
cc -c "$toolkit_directory/language/c/toolkit.c" -o "$build_directory/toolkit.o"
ar rcs "$build_directory/libtoolkit.a" "$build_directory/toolkit.o"
sudo cp "$build_directory/libtoolkit.a" /usr/local/lib/


echo 'installing go toolkit'

mkdir -p ~/projects/go/src/toolkit
cp "$toolkit_directory/language/go/toolkit.go" ~/projects/go/src/toolkit/toolkit.go

echo 'installing python toolkit'

python_site_packages=$( python3 - <<'EOF'
import site; print(site.getsitepackages()[0])
EOF
)

sudo mkdir -p "$python_site_packages/toolkit"
sudo cp "$toolkit_directory/language/python/__init__.py" "$python_site_packages/toolkit/__init__.py"

echo 'installing rust toolkit'

# rustup is keg-only so call it by its full path, this also installs cargo into ~/.cargo/bin
/opt/homebrew/opt/rustup/bin/rustup default stable

mkdir -p ~/.cargo/toolkit/src
cp "$toolkit_directory"/language/rust/*.rs ~/.cargo/toolkit/src/

cat <<EOF > ~/.cargo/toolkit/Cargo.toml
[package]
name = "toolkit"
version = "0.1.0"
edition = "2021"

[lib]
path = "src/toolkit.rs"
EOF

~/.cargo/bin/cargo install --path ~/.cargo/toolkit


echo 'installing typescript toolkit'

mkdir -p ~/projects/typescript/toolkit
cp "$toolkit_directory"/language/typescript/*.ts ~/projects/typescript/toolkit

cat <<EOF > ~/projects/typescript/toolkit/package.json
{
  "name": "toolkit",
  "version": "1.0.0",
  "type": "module",
  "main": "main.ts"
}
EOF

npm install -g ~/projects/typescript/toolkit
