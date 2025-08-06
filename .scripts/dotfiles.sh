#!/bin/bash

backup_dir=~/dotfiles

rm -rf "$backup_dir" 2>/dev/null
mkdir -p "$backup_dir"
echo -n "Creating dotfiles..."

(
	pacman -Qqe > "$backup_dir/installed_packages.txt" &

	mkdir -p "$backup_dir/.config"
	cp -r ~/.config/dunst "$backup_dir/.config/"
	cp -r ~/.config/fastfetch "$backup_dir/.config/"
	cp -r ~/.config/fuzzel "$backup_dir/.config/"
	cp -r ~/.config/ghostty "$backup_dir/.config/"
	cp -r ~/.config/hypr "$backup_dir/.config/"
	cp -r ~/.config/kitty "$backup_dir/.config/"
	cp -r ~/.config/rofi "$backup_dir/.config/"
	cp -r ~/.config/wal "$backup_dir/.config/"
	cp -r ~/.config/waybar* "$backup_dir/.config/"
	cp -r ~/.config/yazi "$backup_dir/.config/"

	wait

) >/dev/null 2>&1

cp ~/.zshrc ~/.zhistory ~/.vimrc "$backup_dir/"
cp -r ~/.scripts "$backup_dir/"
mkdir -p "$backup_dir/.scripts/extra"
[[ -d /usr/local/bin ]] && cp /usr/local/bin/* "$backup_dir/.scripts/extra/"

echo " done!"
