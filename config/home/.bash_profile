#
# ~/.bash_profile
#
# Load bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start Hyprland from tty1
if [[ -z $DISPLAY && -z $WAYLAND_DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
    exec start-hyprland
fi
