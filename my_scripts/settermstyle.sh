#!/bin/bash

cat <<EOF >>~/.bashrc
# Aliases
alias ll='ls -al'
alias update='sudo dnf update'
alias nv='nvim'
alias ls='ls --color=auto'

PS1='\[\e[0;95m\][\[\e[0;94m\]gabriel@\h\[\e[0;95m\]\[\e[0;92m\]\e[0;95m\]] \[\e[0;34m\]\w\[\e[0;90m\]\n\[\e[0;96m\]\$\[\e[0m\] '
EOF

source ~/.bashrc
