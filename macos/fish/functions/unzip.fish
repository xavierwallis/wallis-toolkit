function unzip
    set_color F85
    echo "unzipping..."
    set_color normal

    tar xzf $argv
    rm $argv
end
