# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sasdelli/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Enable autocd feature
setopt autocd

# Load colors
autoload -U colors && colors

# Set the prompt
if [ -n "$IN_NIX_SHELL" ]; then
    PROMPT=$'\n%B%F{cyan}%n@nix-shell %F{blue}%1~%f\n  %F{cyan}λ%f%b '
else
    PROMPT=$'\n%B%F{cyan}%n@%m %F{blue}%1~%f\n  %F{cyan}λ%f%b '
fi

# Alias for nix-shell.
alias nix-shell='nix-shell --command "zsh"'

# Alias for neofetch.
alias neofetch='neofetch --color_blocks off'

# Alias for cmatrix.
alias cmatrix='cmatrix -C cyan'

# Alias for cabal2nix.
alias cabal2nix='cabal2nix --shell . > shell.nix'

# Alias for opam-nix.
alias opam-nix='nix flake init -t github:tweag/opam-nix'

# Alias for ls to use eza.
alias ls='eza'

# Set the terminal title to the current directory
precmd() { print -Pn "\e]0;%~\a" }

# Add different directories to PATH.
export PATH="$HOME/.aiken/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Add NVM to PATH.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Setting Neovim as the default text editor.
export EDITOR="nvim"

# Shell integration for direnv.
eval "$(direnv hook zsh)"

# Git Credential Store.
export GCM_CREDENTIAL_STORE=cache

# Quarto python3 config.
export QUARTO_PYTHON=/run/current-system/sw/bin/python3

# Shell integration for opam.
eval "$(opam env)"

# Shell integration for zoxide.
eval "$(zoxide init --cmd cd zsh)"

# Bind forward-word and backward-word.
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
