function pack
    set_color F85
    echo 'packing...'
    set_color normal

    set --local directory ( basename ( pwd ) )
    set --local compressed ( string join '' $directory '.tar.gz' )
    cd ..
    zip $compressed $directory

    set_color F85
    printf 'packed: %s\npath copied to clipboard.\n' $compressed
    set_color normal

    set --local compressed_path ( string join '' ( pwd ) '/' $compressed )
    echo $compressed_path | pbcopy
end
