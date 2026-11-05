## 0. Prepare

For `Arch Linux`:

```bash
sudo pacman -Syyu hyprland xdg-desktop-portal-hyprland         \
             alacritty fuzzel waybar hyprpaper flameshot       \
             ttf-dejavu ttf-font-awesome wqy-zenhei            \
             ttf-jetbrains-mono ttf-jetbrains-mono-nerd        \
             fcitx5 fcitx5-gtk fcitx5-qt fcitx5-configtool     \
             fcitx5-chinese-addons fcitx5-pinyin-zhwiki        \
             networkmanager network-manager-applet             \
             bluez bluez-utils blueman                         \
             pipewire-pulse pamixer pavucontrol libnotify mako
sudo systemctl enable --now NetworkManager bluetooth
```

---

## 1. Install

Run from the repository root. This copies into an existing `~/.config` or `~/.vim` instead of nesting a second copy inside it.

```bash
cp -r .config .vim ~/
cp -v .bashrc .bash_profile .vimrc .Xresources ~/
chmod +x ~/.config/hypr/xdph.sh ~/.config/waybar/scripts/*
sed -i "s?username?$USER?g" ~/.config/wpaperd/config.toml
```

---

## 2. Run Hyprland

```bash
Hyprland
```

`Super + Return` opens a terminal and `Super + D` opens the launcher. `Super + Q` closes the focused window, `Super + F` maximizes it, and `Super + Alt + Q` exits Hyprland. `Super + 1` through `Super + 5` switch workspaces; add `Shift` to send the focused window there instead. `Super + S` toggles the scratchpad. `Print` saves a screenshot of all outputs to `~` with grim. wpaperd rotates a random wallpaper from `~/.config/wallpaper` every 30 minutes.
