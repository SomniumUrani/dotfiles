# My linux
Configuration files: https://github.com/SomniumUrani/dotfiles

## Desktop
**Hyprland**
- Config: ~/.config/hypr/

**Waybar**
- Config: ~/.config/waybar/config.jsonc
- Theme: ~/.config/waybar/style.css
- Restart: `killall waybar -SIGUSR2`

**Alacritty**
- Config: ~/.alacritty.toml

**Screenshots**
- Package: `slurp`
- SS to clipboard: `grim -g "$(slurp)" - | wl-copy`
- SS to disk: `grim -g "$(slurp)" ~/normieStuff/Pictures/Screenshots/$(date +'%Y-%m-%d_%H-%M-%S')_shot.png`

## Other stuff
**Network Manager**
- Config: `nmtui`

**zsh**
- Config: ~/.zshrc

**neo vim**
- Config: ~/.config/nvim/init.lua

**Battery management**
- Package: `tlp`
- Battery status: `sudo tlp-stat -b` (`bstatus` with my alias)
- Fullcharge: `tlp fullcharge`

**Pacman**
- Clean tools: `paccache`
- Remove things: `sudo paccache -r`
- Remove unused packages: `sudo pacman -Rs $(pacman -Qtdq)`

**SDDM*
- Themes: /usr/share/sddm/themes/

## Cheatsheet
- Dir size: `du -sh`
