function mdcd --description "Create a directory and cd into it"
    mkdir -p "$1" && cd "$1"
end
