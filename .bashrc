#!/bin/bash
#  
#
# Ali Vijdaan's bash environment
# 	~vijdaancoding~


#########################################################################################
# Terminal Settings 
#########################################################################################


# Set terminal type to kitty
export TERMINAL=kitty
export TERM="xterm-kitty"


#########################################################################################
# Exit if Not Running Interactively 
#########################################################################################


case $- in
*i*) ;;		# Continue Running
*) return ;;	# Exit
esac


#########################################################################################
# History Configuration 
#########################################################################################


# Don't put duplicate lines or lines starting with space in the history
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Hisotry size
HISTSIZE=1000
HISTFILESIZE=2000


#########################################################################################
# Shell Behaviour 
#########################################################################################


# Adjust terminal size after each command
shopt -s checkwinsize

# ** Matching 
shopt -s globstar

# Make 'less' smarter with non-text files
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#########################################################################################
# Chroot Identification 
#########################################################################################


if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


#########################################################################################
# Prompt - Taken from Mitchell Hashimoto
#########################################################################################


# Enable color if possible
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# ANSI Color Codes
RED="\[\033[0;31m\]"
BROWN="\[\033[0;33m\]"
GREY="\[\033[0;97m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
PS_CLEAR="\[\033[0m\]"
SCREEN_ESC="\[\033k\033\134\]"

COLOR1="${BLUE}"
COLOR2="${BLUE}"
P="\$"

parse_git_branch() {
  local git_dir=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -n "$git_dir" ]]; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --always 2>/dev/null)
    if [[ -n "$branch" ]]; then
      echo "  $branch"
    fi
  fi
}

# Minimal: folder + branch
prompt_simple() {
  unset PROMPT_COMMAND
  PS1="\[\033[00;32m\]\W\[\033[33m\]\$(parse_git_branch)\[\033[00m\] → "
  PS2="> "
}

# Compact: just a colored $
prompt_compact() {
  unset PROMPT_COMMAND
  PS1="${COLOR1}${P}${PS_CLEAR} "
  PS2="> "
}

# Colored 
prompt_color() {
  unset PROMPT_COMMAND
  local docker_icon=""
  local venv_indicator=""
  
  if grep -qa docker /proc/1/cgroup 2>/dev/null; then
    docker_icon=" 🐳" # Whale for Docker
  fi
  
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_name="${VIRTUAL_ENV##*/}"
    venv_indicator=" (${venv_name})"
  fi
  
  local arrow_color="\[\033[36m\]" # Cyan
  local reset_color="\[\033[00m\]" # Reset color
  

  PS1="${GREEN}${docker_icon}${venv_indicator}${reset_color}\[\033[00;32m\]\w\[\033[33m\]\$(parse_git_branch)${reset_color}\n${arrow_color}❯${reset_color} "
  PS2="\[\033[33;1m\]continue \[\033[0;1m\]> "
}

# Set default prompt
prompt_color


#########################################################################################
# LS / Grep / Alias
#########################################################################################


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Custom Alias
alias nv='nvim' 
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' 

# Source ~/.bash_aliases if it exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


#########################################################################################
# Bash Completions
#########################################################################################


if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi


#########################################################################################
# Paths 
#########################################################################################

# Created by `pipx` on 2025-01-05 12:22:46
export PATH="$PATH:/home/ali-vijdaan/.local/bin"

# Flutter SDK
export PATH="$HOME/Development/flutter/bin:$PATH"

# Ruby Version Manager
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Node Version Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Rust Environment
. "$HOME/.cargo/env"

#########################################################################################
# Tmux 
#########################################################################################


if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [ -n "$PS1" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi


