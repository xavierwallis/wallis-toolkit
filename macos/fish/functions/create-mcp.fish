function create-mcp
    set --local directory $argv[1]
    set_color F85
    echo making mcp project $directory
    mkdir $directory
    cd $directory
    deno init
    deno add npm:zod npm:@modelcontextprotocol/sdk
    cat ~/projects/wallis-toolkit/mcp-servers/typescript/boilerplate.ts >main.ts
    echo ( printf '{ "%s": { "command": "deno", "args":["run","--allow-all","~/projects/wallis-toolkit/mcp-servers/typescript/%s/main.ts"]} }' $directory $directory ) >buildscript.json
    echo finished creating mcp project $directory
end
