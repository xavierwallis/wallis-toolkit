function create-venv
    set_color F85
    echo Creating ( python3 --version | string lower | string replace ' ' '-' ) virtual environment at ( string join '' ( basename ( pwd ) ) '/.venv' )
    python3 -m venv .venv
    bass source ./.venv/bin/activate

    if test -e requirements.txt
        echo Found requirements.txt -- installing...
        ./.venv/bin/pip3 install -r requirements.txt
    end
end
