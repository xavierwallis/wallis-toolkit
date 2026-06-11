set fish_greeting

thefuck --alias | source

tmux source-file ~/.config/tmux.conf

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/anaconda3/bin/conda
    eval /opt/homebrew/anaconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /opt/homebrew/anaconda3/bin $PATH
    end
end
# <<< conda initialize <<<
#
set -gx PATH $PATH $HOME/.dotnet/tools

# OrbStack
set -gx PATH $PATH /Applications/OrbStack.app/Contents/MacOS/xbin

alias vim=nvim
alias libreoffice="/Applications/LibreOffice.app/Contents/MacOS/soffice"
alias hawley="ssh -p 95 hawley@remote.cat-peeler.com"
alias bing="ssh cwallis1@remote.cs.binghamton.edu"
alias start-docker="orb"
alias spotify=spotatui
alias clearls="clear&&ls"
