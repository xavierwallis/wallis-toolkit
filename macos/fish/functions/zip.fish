function zip
    set_color F85
    echo 'zipping...'
    set_color normal
    echo $argv
    tar czfv $argv
end
