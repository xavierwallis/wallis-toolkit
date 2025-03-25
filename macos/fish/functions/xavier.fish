function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
        set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end


    set_color yellow
    printf '%s' $user

    set_color normal
    printf ' at '

    set_color magenta
    echo -n ( prompt_hostname )

    set_color normal
    printf ' in '

    set_color $fish_color_cwd
    printf '%s' ( prompt_pwd )


    # branchname
    if set --local git_branch ( command git symbolic-ref HEAD 2>/dev/null | string replace refs/heads/ '' )
        set_color normal
        printf ' on ' $git_branch

        set_color F85
        printf '%s' $git_branch

        set_color normal
        printf ' using '

        # package
        set_color 36F
        printf '%s' ( ls -R | string match --regex --groups-only '(?:\.)(?:([a-z]{1,})\s?)$' | uniq -c | sort | tail -1 | string replace --regex '\d+\s*' '' )

    end

    set_color normal
    echo
    if test -n "$VIRTUAL_ENV"
        printf "(%s) " ( set_color blue )( basename $VIRTUAL_ENV )( set_color normal )
    end
    printf '↪ '
    set_color normal
end
