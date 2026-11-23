if status is-interactive
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias lg=lazygit
    alias hunk='hunk diff --watch'
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

fnm env | source

if test -z "$WAYLAND_DISPLAY"; and test "$XDG_VTNR" -eq 1
    exec sway
end

set -gx EDITOR helix
set -gx BROWSER zen

# fnm
set -gx PATH "/Users/ilyaaa/.local/state/fnm_multishells/39823_1793828244270/bin" $PATH
set -gx FNM_MULTISHELL_PATH "/Users/ilyaaa/.local/state/fnm_multishells/39823_1793828244270"
set -gx FNM_VERSION_FILE_STRATEGY local
set -gx FNM_DIR "/Users/ilyaaa/.local/share/fnm"
set -gx FNM_LOGLEVEL info
set -gx FNM_NODE_DIST_MIRROR "https://nodejs.org/dist"
set -gx FNM_COREPACK_ENABLED false
set -gx FNM_RESOLVE_ENGINES true
set -gx FNM_ARCH arm64
