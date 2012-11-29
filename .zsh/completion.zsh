#!/bin/zsh

autoload -U compinit 
compinit

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

autoload -U select-word-style
select-word-style bash

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# Disable username lookup = don't look up NIS users
# <http://www.zsh.org/mla/users/2004/msg01280.html>
zmodload -i zsh/parameter
_comp_setup+=$'\ntypeset -a userdirs'

#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' completer _expand _complete _correct
zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt autolist

# Color completion lists in accordance with ZLS_COLORS
zmodload zsh/complist
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Make rm not offer the same file, if it's already on the cmd line
zstyle ':completion:*:rm:*' ignore-line yes

# See <http://stackoverflow.com/questions/171563/whats-in-your-zshrc>, asnwer
# from "a paid nerd"
# On slow infrastructure where tab-completion takes a while? Show "waiting dots"
# while something tab-completes. (found on zsh-users)
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
