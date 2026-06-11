function download-mp3
    set_color F85
    echo "Downloading mp3 from $argv"
    set_color FFF
    yt-dlp --extract-audio --audio-format mp3 $argv
end
