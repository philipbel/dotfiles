#!/bin/zsh

BIND=emacs

case $BIND in
*emacs*)
    bindkey -e
    # del
    bindkey '\e[3~' delete-char
    # home
    bindkey '^[OH' beginning-of-line
    # end
    bindkey '^[OF' end-of-line
    # page up
    bindkey '^[[5~' up-line-or-history
    # page up
    bindkey '^[[6~' down-line-or-history
    # Ctrl+Alt+R = complete using the beginning of the line
    bindkey "^[^R" history-beginning-search-backward
    ;;
*vim*)
    bindkey -v
    bindkey "^W" backward-kill-word
    bindkey "^H" backward-delete-char
    bindkey "^U" kill-line
    bindkey "^?" backward-delete-char
    ;;
*)
    echo "Unknown editor!"
esac

