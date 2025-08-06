#!/bin/bash

if [[ $1 == "reset" ]]; then
    hyprctl hyprsunset identity
    hyprctl hyprsunset gamma 100
    exit
fi

type=$1
change=$2

case $type in
    temperature)
        current=$(hyprctl hyprsunset temperature | awk '{print int($1)}')
        new=$((current + change))
        ((new = new < 2000 ? 2000 : new > 10000 ? 10000 : new))
        hyprctl hyprsunset temperature $new
	notify-send --replace-id=41 "🌡️ Temp: $new"
        ;;
    gamma)
        current=$(hyprctl hyprsunset gamma | awk '{print int($1 + 0.5)}')
        new=$((current + change))
        ((new = new < 40 ? 40 : new > 100 ? 100 : new))
        hyprctl hyprsunset gamma $new
	notify-send --replace-id=41 "🌤️ Gamma: $new"
        ;;
esac
