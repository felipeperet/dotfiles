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

# Set the terminal title to the current directory
precmd() { print -Pn "\e]0;%~\a" }

# Add Oura to PATH.
export PATH=$PATH:~/bins/oura/target/release

# Add different directories to PATH.
export PATH=$PATH:$(pwd)/result/bin
export PATH=$PATH:~/.cargo/bin
export GRDIR=$PATH:~/.julia/packages/GR

# Shell integration for direnv.
eval "$(direnv hook zsh)"

# Shell integration for opam.
eval "$(opam env)"

# Shell integration for zoxide.
eval "$(zoxide init --cmd cd zsh)"

# Bind forward-word and backward-word.
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
