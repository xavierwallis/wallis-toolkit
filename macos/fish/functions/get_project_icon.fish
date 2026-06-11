function get_project_icon
    # Check if git is available and we're in a repo
    if not command -v git >/dev/null
        return
    end

    if not git rev-parse --is-inside-work-tree >/dev/null 2>&1
        return
    end

    # Extension to language mapping
    set -l extension_to_language
    set extension_to_language[js]   javascript
    set extension_to_language[mjs]  javascript
    set extension_to_language[ts]   typescript
    set extension_to_language[py]   python
    set extension_to_language[rs]   rust
    set extension_to_language[go]   go
    set extension_to_language[rb]   ruby
    set extension_to_language[java] java
    set extension_to_language[kt]   kotlin
    set extension_to_language[swift] swift
    set extension_to_language[c]    c
    set extension_to_language[h]    c
    set extension_to_language[cpp]  cpp
    set extension_to_language[cc]   cpp
    set extension_to_language[hs]   haskell
    set extension_to_language[php]  php
    set extension_to_language[md]   markdown
    set extension_to_language[sh]   shell
    set extension_to_language[fish] fish
    set extension_to_language[html] html
    set extension_to_language[css]  css
    set extension_to_language[scss] css
    set extension_to_language[yml]  yaml
    set extension_to_language[yaml] yaml
    set extension_to_language[json] json
    set extension_to_language[toml] toml
    set extension_to_language[zig]  zig
    set extension_to_language[lua]  lua
    set extension_to_language[nix]  nix

    # Language to icon mapping (Nerd Font icons)
    set -l language_to_icon
    set language_to_icon[javascript]  ''
    set language_to_icon[typescript]  ''
    set language_to_icon[python]      ''
    set language_to_icon[rust]        ''
    set language_to_icon[go]          ''
    set language_to_icon[ruby]        ''
    set language_to_icon[java]        ''
    set language_to_icon[kotlin]     ''
    set language_to_icon[swift]      ''
    set language_to_icon[c]          ''
    set language_to_icon[cpp]        ''
    set language_to_icon[haskell]    ''
    set language_to_icon[php]        ''
    set language_to_icon[markdown]   ''
    set language_to_icon[shell]      ''
    set language_to_icon[fish]       '󰈺'
    set language_to_icon[html]       ''
    set language_to_icon[css]        ''
    set language_to_icon[yaml]       ''
    set language_to_icon[json]       ''
    set language_to_icon[toml]       ''
    set language_to_icon[zig]        ''
    set language_to_icon[lua]        ''
    set language_to_icon[nix]        ''

    # Count language occurrences
    set -l lang_counts
    for file in (git ls-files)
        # Extract lowercase extension
        set -l ext (string split -r -m1 . -- (basename -- $file))[-1]
        set ext (string lower "$ext")

        if set -q extension_to_language[$ext]
            set -a lang_counts $extension_to_language[$ext]
        end
    end

    # Find most common language
    set -l primary_lang (printf "%s\n" $lang_counts | sort | uniq -c | sort -nr | head -n1 | awk '{print $2}')

    if test -n "$primary_lang" && set -q language_to_icon[$primary_lang]
        printf "%s" $language_to_icon[$primary_lang]
    else
        # Default icon if no detected language
        printf "󰉋"
    end
end
