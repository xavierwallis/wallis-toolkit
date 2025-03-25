function pack
    set_color F85
    echo 'packing...'
    set_color normal

    set --local directory ( basename ( pwd ) )
    cd ..
    zip $directory
end
