export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="heapbytes"

plugins=(
    git
    git-flow
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    pyenv
    thefuck
    zsh-navigation-tools
    asdf
    python
    docker
    docker-compose
    tmux
    tmuxinator
    httpie
    procs
    poetry
)

source $ZSH/oh-my-zsh.sh

# Set-up icons for files/folders in terminal
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

export PATH="$HOME/.local/bin:$PATH"
export CM_CACHE="$HOME/.cache/clipmenu"