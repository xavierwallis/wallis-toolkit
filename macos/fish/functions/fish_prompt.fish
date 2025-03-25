function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end
    set_color yellow
    printf '%s' $USER
    set_color normal
    printf ' at '

    set_color magenta
    echo -n (prompt_hostname)
    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    if set --local git_branch ( command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '' )
        printf ' on '

        set_color F85
        printf '%s' git_branch

        set_color normal
        printf ' using '

        set_color 36F
        printf '%s ' ( ls -R | string match --regex --groups-only '(?:\.([a-z]{1,3})\s?)$' | uniq --count | sort | tail -1 | string replace --regex '^[\s\d]{1,}' '' )
    end
    # Line 2

    set_color normal
    echo
    if test -n "$VIRTUAL_ENV"
        printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
    end
    printf '↪ '
    set_color normal
end
