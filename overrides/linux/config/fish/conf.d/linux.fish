# Linux TTY autostart: when there is no Wayland session and we are on VT1,
# hand the console over to sway.
if test -z "$WAYLAND_DISPLAY"; and test "$XDG_VTNR" -eq 1
    exec sway
end
