#!/bin/sh
#Installation directory
BUNDLE_DIR=~/.vim/bundle
INSTALL_DIR="$BUNDLE_DIR/vundle.vim"
echo "install at $INSTALL_DIR"
if [-e "$INSTALL_DIR"]; then
    echo "$INSTALL_DIR already exists!"
fi

#check git command
if type git; then
    :#If you have git command, No problem.
else
    echo 'Please install git or update your path to include the git executable!'
    exit 1
fi

#check ctags command
if type ctags; then
    :#If you have git command, No problem
else
    echo 'Please install ctags or update your path to include the ctags executable!'
    exit 1
fi

#make bundle dir and fetch bundle
echo 'check install directory'
if ![-e "$INSTALL_DIR"]; then
    mkdir -p "$BUNDLE_DIR"
fi

#If install directory already exist, install will contine.
echo 'start install vundle'
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#Vundle Install
echo 'copyed ~/.vimrc'
cp ./firstvim ~/.vimrc
vim +PluginInstall +qall

#vimrc setup for Ctag
#cp ./vimrc ~/.vimrc
#vim +PluginInstall +qall

