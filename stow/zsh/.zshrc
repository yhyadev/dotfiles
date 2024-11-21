export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="simple" # set by `omz`

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

zstyle ':omz:update' frequency 7 # specify every 7 days as the frequency of remainder

plugins=(
    wakatime
    git
    golang rust pip python 
    themes
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

export PATH="$HOME/.local/bin:$PATH"

# Zoxide
eval "$(zoxide init zsh)"

# Rust Cargo
source $HOME/.cargo/env

# Go
export PATH="$HOME/go/bin:$PATH"
export GOROOT="/usr/local/lib/go"
export GOPROXY=https://proxy.golang.org,direct
export GOSUMDB=sum.golang.org
export GOTOOLCHAIN=auto

# C3
export PATH="$HOME/.local/bin/c3/:$PATH"

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null
# END opam configuration
