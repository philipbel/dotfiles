#!/bin/zsh

function precmd()
{
    # TODO: git branch

    # The following 9 lines of code comes directly from Phil!'s ZSH prompt
    # http://aperiodic.net/phil/prompt/
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))

    # set a simple variable to show when in screen
    if [[ -n "${WINDOW}" ]]; then
        PR_SCREEN=" S:${WINDOW}"
    else
        PR_SCREEN=""
    fi

    # check if jobs are executing
    if [[ $(jobs | wc -l) -gt 0 ]]; then
        PR_JOBS=" J:%j"
    else
        PR_JOBS=""
    fi
}

# If I am using vi keys, I want to know what mode I'm currently using.
# zle-keymap-select is executed every time KEYMAP changes.
# From http://zshwiki.org/home/examples/zlewidgets
function zle-keymap-select {
    VIMODE="${${KEYMAP/vicmd/ M:command}/(main|viins)/}"
    zle reset-prompt
}

zle -N zle-keymap-select

setprompt()
{
    autoload colors zsh/terminfo
	colors

	CHROOT=''

	# Midnight commander doesn't display coloured prompt
	if [ -n "$MC_SID" ]; then
		TERM="dumb"
	fi
	if [ $TERM = "dumb" ]; then
		PROMPT="[%2c]${CHROOT}$ "
		PS2="%_> "
	else
		#USER_CHAR="%%"
		#if [ `id -un` = "root" ]; then
		#	USER_CHAR="#"
		#fi
		#PROMPT="%{$PR_NO_COLOR%}[%{$fg[green]%}%2c%{$PR_NO_COLOR%} @${HOST}]%{$fg[green]%}${CHROOT}${USER_CHAR}$PR_NO_COLOR "		

        PS2="%{$fg[green]%}%_%{$reset_color%}> "
		
		# From walter's prompt in Debian
		#export PROMPT='%B%(?..[%?] )%b%n@%{$fg[red]%}%m%{$PR_NO_COLOR%}%u%# '
		export PROMPT='%b%n@%{$fg[red]%}%m%{$reset_color%}%u%# '
    	#export RPROMPT="%{$fg[green]%}%~%f%{$PR_NO_COLOR%}"
		export RPS1='(%{$fg[green]%}%20<...<${VIMODE}%~%{$reset_color%})'
	fi
}


# This function is called automatically whenever the directory changes
# and sets the title in the terminal window
chpwd()
{
    [[ -t 1 ]] || return

    case $TERM in
	*xterm*|rxvt|(dt|k|E|)term)
	    print -Pn "\e]2;%~ @${HOST}\a"
    	;;
    esac
}

autoload -U promptinit
promptinit
setopt prompt_subst

setprompt
chpwd
