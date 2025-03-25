function unpack
    set_color F85
    echo "unpacking..."
    set_color normal
    unzip $argv
    cd ( string replace -r '\.tar\.gz$' '' -- $argv[1] )
    onefetch
end
