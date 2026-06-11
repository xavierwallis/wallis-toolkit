function create-roblox
    # directory setup
    set_color $fish_color_command
    echo 'making directory'
    set_color normal
    mkdir $argv[1]
    cd $argv[1]

    # toolchain setup
    set_color $fish_color_param
    echo 'Building Toolchain'
    set_color normal
    rokit init
    rokit add rojo
    rojo init
    wally init

    # build the roblox application and serve
    set_color $fish_color_error
    echo 'Building project and opening LOL'
    set_color normal
    rojo build -o "$argv[1].rbxlx"
    open "$argv[1].rbxlx"

    echo "hey asshole ctrl + space + v -> rojo serve"
end
