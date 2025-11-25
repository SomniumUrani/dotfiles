#!/bin/bash

cp ~/.zshrc .
cp ~/.config/nvim/init.vim .
cp ~/.alacritty.toml .
cp ~/.config/waybar/config.jsonc waybar/
cp ~/.config/waybar/style.css waybar/
cp ~/.config/hypr/* hyprland/

git add .
git commit -m "1% better this time"
