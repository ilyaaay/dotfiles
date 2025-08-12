if status is-interactive
    fastfetch

    alias hx=helix
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias rm='rm -i'
end

# get previous command
function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t -- $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -f backward-delete-char history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind ! bind_bang
    bind '$' bind_dollar
end

function yz
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

fnm env | source

if test -z "$WAYLAND_DISPLAY"; and test "$XDG_VTNR" -eq 1
    exec sway
end

set -gx EDITOR helix
