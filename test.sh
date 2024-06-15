#!/bin/bash
mv $HOME.config/$1 $HOME/git/myconfig/dotfiles/$1
ln -s $HOME/git/myconfig/dotfiles/$1 $HOME.config/$1
