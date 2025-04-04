function getline
    cat $argv[1] | head -$argv[2] | tail -1
end
