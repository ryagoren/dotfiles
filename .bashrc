# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


cyan='\[\e[38;2;133;233;248m\]'
blue='\[\e[38;2;110;162;247m\]'
tan='\[\e[38;2;242;225;209m\]'
spk='\[\e[1m\e[38;2;255;154;239m\]'
lpk='\[\e[1m\e[38;2;255;207;232m\]'
white='\[\e[0m\]'
neut='\[\e[1m\e[38;2;192;202;245m\]'


# cerulean = "0492C2"

# fdf96
# fdfdaf also nice
bpy='\[\e[1m\e[38;2;253;253;150m\]'
py='\[\e[38;2;253;253;150m\]'

# yeah nicer
pys='\[\e[1m\e[38;2;253;253;175m\]'


# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

alias nvi="nvim"
alias iconfig="nvim ~/.config/i3/config"
alias xcsc="xclip -selection clipboard"
alias polyconfig="nvim ~/.config/polybar/config.ini"
alias piconfig="nvim ~/.config/picom/picom.conf"
alias alconfig="nvim ~/.config/alacritty/alacritty.toml"
alias kitconfig="nvim ~/.config/kitty/kitty.conf"
alias wezconfig="nvim ~/.config/wezterm/wezterm.lua"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

export PS1="┌─[$lpk\u$neut@$lpk\h$neut:$tan\w$neut]$pys\$(parse_git_branch)$neut\n└─╼ "

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export PATH=$PATH:~/local/bin:~/.cargo/bin
export EDITOR='nvim'
export QMK_HOME=/home/ryangeor/git/qmk_parent/qmk


if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Enable Git autocompletion
if [[ ! -f ~/git-completion.bash ]]; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > ~/git-completion.bash
fi
source ~/git-completion.bash

#. "$HOME/.cargo/env"

set -o vi

if [[ -z "$ZELLIJ" ]]; then
    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi
