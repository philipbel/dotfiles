if test (uname -s) = "Darwin" && test -d /Applications/GitX.app
    alias gitx='open -a GitX'
else
    alias gitx='gitk >/dev/null'
end
alias gitka='gitk --all'

alias gitx='open -a GitX'
