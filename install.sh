#!/usr/bin/env bash

# User variables
USER_SURNAME="Erri"
USER_NAME="Mika"
USER_EMAIL="erri.mika@gmail.com"
USER_GITHUB_NAME="mikae"

# Find script parent dir path.
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Path variables
PATH_AWESOME_WM=$DIR/dotfiles_awesome_wm
PATH_EMACS=$DIR/dotfiles_emacs
PATH_LINUX=$DIR/dotfiles_linux
PATH_USER=$DIR/dotfiles_user
PATH_ZSH=$DIR/dotfiles_zsh
PATH_VIM=$DIR/dotfiles_vim

# Install parameters
INSTALL_AWESOME_WM=false
INSTALL_EMACS=false
INSTALL_LINUX=false
INSTALL_USER=false
INSTALL_ZSH=false
INSTALL_VIM=false

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --awesome-wm)
            INSTALL_AWESOME_WM=true
        ;;

        --emacs)
            INSTALL_EMACS=true
        ;;

        --zsh)
            INSTALL_ZSH=true
        ;;

        --vim)
            INSTALL_VIM=true
        ;;

        --linux)
            INSTALL_LINUX=true
        ;;

        --user)
            INSTALL_USER=true
        ;;

        --all)
            INSTALL_AWESOME_WM=true
            INSTALL_EMACS=true
            INSTALL_ZSH=true
            INSTALL_VIM=true
            INSTALL_LINUX=true
            INSTALL_USER=true
        ;;
    esac

    shift
done

# Update all submodules to latest versions
git submodule update --recursive --remote

# Export variable to be usable in scripts
export USER_SURNAME
export USER_NAME
export USER_EMAIL
export USER_GITHUB_NAME

# Install them
if [ "$INSTALL_AWESOME_WM" = true ]; then
    $PATH_AWESOME_WM/install.sh --all
fi

if [ "$INSTALL_EMACS" = true ]; then
    $PATH_EMACS/install.sh --all
fi

if [ "$INSTALL_ZSH" = true ]; then
    $PATH_ZSH/install.sh --all
fi

if [ "$INSTALL_VIM" = true ]; then
    $PATH_VIM/install.sh
fi

if [ "$INSTALL_LINUX" = true ]; then
    cd $PATH_LINUX
    $PATH_LINUX/install.sh
    cd -
fi

if [ "$INSTALL_USER" = true ]; then
    cd $PATH_USER
    $PATH_USER/install.sh
    cd -
fi
