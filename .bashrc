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

neut='\[\e[38;2;230;230;250m\]'
# cerulean = "0492C2"
## yellows
# fdf96
# fdfdaf also nice
# ff8994
bpy='\[\e[1m\e[38;2;253;253;150m\]'
py='\[\e[38;2;253;253;150m\]'
pys='\[\e[1m\e[38;2;253;253;175m\]'
pantone='\[\e[38;2;242;240;161m\]'
paleyel='\[\e[38;2;245;245;220m\]'
chifyel='\[\e[38;2;255;250;205m\]'
pty='\[\e[38;2;251;236;193m\]'

# light lav
lv='\[\e[38;2;230;230;250m\]'
vlv='\[\e[38;2;180;160;255m\]' # good 
elv='\[\e[38;2;191;119;246m\]' 
rlv='\[\e[38;2;177;102;255m\]'
nlv='\[\e[38;2;177;102;255m\]'


pc='\[\e[38;2;240;128;128m\]'
pgr='\[\e[38;2;135;206;235m\]'
pdb='\[\e[38;2;176;224;230m\]'

cool='\[\e[1m\e[38;2;158;206;106\]'

[[ -e "$HOME/.dircolors" ]] && eval "$(dircolors -b "$HOME/.dircolors")"

function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo "*"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

nontext="$lv"
hostuser="$lpk"
ppath="$pty"
gbranch="$vlv"
export PS1="$hostuser\u$nontext@$hostuser\h$nontext:$ppath\w$gbranch\$(parse_git_branch)"$nontext" $white"

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

# enable color support of ls and also add handy aliases
# some more ls aliases

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias ll='ls -lit --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'

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
