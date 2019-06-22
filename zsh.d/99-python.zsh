# Python
export PIPENV_VENV_IN_PROJECT=1
export PATH="$HOME/.poetry/bin:$PATH"
fpath+=~/.poetry/poetry.zsh-completion

###############################################################################
# Python
###############################################################################
export PYTHONDONTWRITEBYTECODE=1
PYTHONPATH=$PYTHONPATH:~/.python.d
#for i in $(find /usr/local/lib -maxdepth 1 -type d -name 'python*'); do
#    local dir="$i/site-packages"
#    if [ -d "$dir" ]; then
#        PYTHONPATH=$PYTHONPATH:$dir
#    fi
#done
export PYTHONPATH
