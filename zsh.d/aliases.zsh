alias m='most'

alias xx='chmod +x'

# Git
if [ `uname -s` = "Darwin" -a -d /Applications/GitX.app ]; then
    alias gitx='open -a GitX'
else
    alias gitx='gitk >/dev/null'
fi
alias gitka='gitk --all'

# On Darwin, prefer Emacs.app, if it's available
if [ `uname -s` = "Darwin" ]; then
	if [ -x /Applications/Emacs.app/Contents/MacOS/Emacs ]; then
		alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	fi
fi
alias e=emacs
alias em='emacs --no-window-system'
alias emm='emacs --no-init-file --no-site-file --no-window-system'
alias ec='emacsclient --no-wait'


function psg()
{
    ps ax | grep -i $@
}

function refresh()
{
    source ~/.zshrc
    rehash
}

function mdcd()
{
    mkdir -p $1 && cd $1
}

alias o="open_command"