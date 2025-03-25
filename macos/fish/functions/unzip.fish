function unzip
    set_color F85
    echo "unzipping..."
    set_color normal

    tar xzfv $argv
    rm $argv
end
