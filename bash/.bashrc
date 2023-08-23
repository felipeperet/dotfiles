# ~/.bashrc

# Enables color support of ls and also adds handy aliases.
export LS_OPTIONS='--color=auto'
# 'dircolors -b' will output shell commands to set the LS_COLORS environment variable.
# These commands are then evaluated with 'eval'.
eval "$(dircolors -b)"
# Create an alias for 'ls' that uses the options specified above.
alias ls='ls $LS_OPTIONS'

# Title
# This will set the title of the terminal window to show user, hostname, and current directory.
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'

# Define the bash prompt.
# Two different versions are defined, one for normal users and one for the root user.
if [[ ${EUID} == 0 ]] ; then
    # If the user is root, color the prompt in red.
    PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
else
    # For normal users, color the prompt in cyan and ~ in blue.
    PS1='\[\033[01;36m\]\n\u@\h\[\033[01;34m\] \W\[\033[01;36m\]\n  λ  \[\033[00m\]'
fi

# Add the ./result-bin/bin directory to PATH.
export PATH=$PATH:$(pwd)/result-bin/bin

# Alias for neofetch.
alias neofetch='neofetch --color_blocks off'
