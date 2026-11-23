if status is-interactive
    alias lg=lazygit
    alias hunk='hunk diff --watch'

    # GNU ls/grep colors only make sense on Linux; macOS ships BSD tools.
    if test (uname) != Darwin
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
    end
end

function mkcd
    if test (count $argv) -eq 0
        echo "Usage: mkcd <directory>"
        return 1
    end

    mkdir -p -- $argv[1]; and cd -- $argv[1]
end

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

# fnm sets PATH itself, so no generated export block is committed here.
if type -q fnm
    fnm env | source
end

set -gx EDITOR hx
set -gx BROWSER zen

# Machine-private settings (paths, tokens, work-only env) go here.
# The file is gitignored and never linked, edit it in place:
#   ~/.config/fish/conf.d/local.fish
