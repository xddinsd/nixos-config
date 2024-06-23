# Matthias' NixOS build configured for me


## Chosen host to fork: probook, others unchanged


* System Components     

|                 | *NixOS - Xorg*   |
|-----------------|------------------|
| *DM*            | LightDM          |
| *WM/DE*         | Bspwm            |
| *Compositor*    | Picom (jonaburg) |
| *Bar*           | Polybar          |
| *Hotkeys*       | Sxhkd            |
| *Launcher*      | Rofi             |
| *GTK Theme*     | Orchis-Dark      |
| *Notifications* | Dunst            |
| *Terminal*      | Alacritty        |



# NixOS Installation Guide
#### Disk partitioning (only UEFI)
*Create a partition layout using disko*
- Get a liveCD of nix with gnome and open this page
- Copy what's in disko.nix file to your home folder, for ex. by using nano.
- change disk name in disko.nix (you could use 'lsblk' command)

```console

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko.nix

```

### Generate
*In these commands*
- Configuration files are generated __/mnt/etc/nixos__
- Clone repository
```bash
  sudo -i
  nixos-generate-config --root /mnt
  nix-env -iA nixos.git
  git clone https://github.com/xddinsd/nixos-config /mnt/etc/nixos/<username>
  cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/<username>/hosts/probook/
```

- Configure your username in flake.nix
 
### Install
*In these commands*
- Move into cloned repository
  - in this example __/mnt/etc/nixos/<username>__
- Install nixos

```bash
  cd /mnt/etc/nixos/<username>
  nixos-install --flake .#probook
```

** Finalization
1. Set a root password after installation is done
2. Reboot without liveCD
3. Login
   1. If initialPassword is not set use TTY:
      - ~Ctrl - Alt - F1~
      - login as root
      - ~# passwd <username>~
      - ~Ctrl - Alt - F7~
      - login as user
4. Remove extra configs
```bash
sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/hardware_configuration.nix
```

5. Rebuilds:
```bash
sudo nixos-rebuild switch --flake <config path>#probook
```
