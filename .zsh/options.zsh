#!/bin/zsh
# ~/.zsh/options.zsh

HISTFILE=~/.zshhistory
HISTSIZE=3000
SAVEHIST=3000


# Don't replace, always append to the history
#setopt append_history
# Same as above, but don't wait until the shell has exited to append to the file
setopt inc_append_history
# When using ! cmds, confirm first
setopt hist_verify

setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt autocd
setopt longlistjobs
setopt histignoredups
# Allows > redirection to truncate existing ﬁles, and >> to create ﬁles.
# Otherwise >! or >| must be used to truncate a ﬁle, and >>! or >>| to
# create a ﬁle.
setopt noclobber
setopt completeinword
setopt autopushd
setopt promptsubst
setopt extendedglob
setopt always_to_end            # When complete from middle, move cursor
unsetopt correct                # Spelling correction
setopt interactive_comments     # Escape commands so I can use them later
unsetopt print_exit_value         # Alert me if something's failed

unsetopt beep bgnice
unsetopt correctall

zmodload -a colors
zmodload -a autocomplete

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ESC-h, ESC-H, ALT-h or ALT-H are going to bring up the man page
autoload -U run-help

# To recompile the zsh code
autoload -U zrecompile

## FAQ 3.10: Why does zsh not work in an Emacs shell mode any more?
### http://zsh.sourceforge.net/FAQ/zshfaq03.html#l26
[[ $EMACS = t ]] && unsetopt zle

# From resolve (http://repose.cx/conf/.zshrc)
WORDCHARS=''                    # Emacs compatible M-b and M-f
bindkey "\C-w" kill-region      # Emacs C-w command support

#autoload -U zsh-mime-setup
#zsh-mime-setup

# Keybindins
bindkey -e
# bindkey -v
