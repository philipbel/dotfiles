function psg --description "grep for a process"
    ps ax | grep -i $argv
end
