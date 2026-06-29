#!/bin/bash
cp ~/.zshrc .
cp ~/.config/nvim/init.lua .
cp ~/.alacritty.toml .
cp ~/.config/waybar/config.jsonc waybar/
cp ~/.config/waybar/style.css waybar/
cp ~/.config/hypr/* hyprland/
cp -r ~/scripts/ .
cp -r ~/.var/app/com.prusa3d.PrusaSlicer/config/PrusaSlicer/snapshots ./prusa-slicer-snapsshots/

git add .
git commit -m "1% better this time"
