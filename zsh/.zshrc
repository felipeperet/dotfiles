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

# Load colors
autoload -U colors && colors

# Set the prompt
PROMPT=$'\n%B%F{cyan}%n@%m %F{blue}%1~%f\n  %F{cyan}λ%f%b '

# Alias for neofetch.
alias neofetch='neofetch --color_blocks off'

# Set the terminal title to the current directory
precmd() { print -Pn "\e]0;%~\a" }

# Add the ./result-bin/bin directory to PATH.
export PATH=$PATH:$(pwd)/result-bin/bin
