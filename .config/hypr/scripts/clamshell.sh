#!/usr/bin/env zsh

NUMBER_MONITORS=$(hyprctl monitors all | grep "^Monitor [a-zA-Z]*-[0-9] (ID [0-9]):" | wc -l)
LAPTOP_DISABLED=$(hyprctl monitors all | grep -A20 "eDP-1" | grep "disabled" | cut -d " " -f2)
LID_STATE=$(cat /proc/acpi/button/lid/LID0/state | cut -d ":" -f2 | sed 's/ *//')

# lid is closed?
if [ "$LID_STATE" = "closed" ]; then
    # is docked?
    if [ $NUMBER_MONITORS -gt 1 ]; then
        # check if laptop screen is disabled (true = disabled)
        if [ "$LAPTOP_DISABLED" = "false" ]; then
            hyprctl keyword monitor "eDP-1,disable"
        fi
elif [ "$LID_STATE" = "open" ]; then
    # is docked?
    if [ $NUMBER_MONITORS -gt 1 ]; then
        if [ "$LAPTOP_DISABLED" = "true"]
            hyprctl keyword monitor "eDP-1,3840x2400@59.99,278x1440,2.0"
        fi
    fi
else
    hyprctl keyword monitor "eDP-1,3840x2400@59.99,278x1440,2.0"
fi
