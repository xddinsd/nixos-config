# Matthias' BSPWM NixOS build reconfigured


## Chosen host to fork: probook, others unchanged

#### To Do list:
- DONE:     Minimal setup
- DONE:     All programs I need
- DONE:     Hotkeys
- DONE:     Documentation 
- WIP:      Theming (Polybar and rofi look awful, had not enough time to fix it yet)
- IN QUEUE: Remove legacy files from Matthias' build


## System Components     

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
- Copy what's in disko.nix file to your home folder, with ```nano``` for ex.
- change disk name in disko.nix (you could use ```lsblk```)

```console

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disko.nix

```
For legacy boot check the Disko page on github, there are a lot of examples💯


### Generate
*In these commands*
- Configuration files are generated __/mnt/etc/nixos__
- Clone repository
```bash
  sudo -i
  nixos-generate-config --root /mnt
  nix-env -iA nixos.git
```
```bash
  git clone https://github.com/xddinsd/nixos-config /mnt/etc/nixos/<username>
```
```bash
cp /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/<username>/hosts/probook/
```

- Configure manually your username in flake.nix
- Add comma for './games.nix' in __/modules/programs/default.nix__ if no steam needed
 
### Install
*In these commands*
- Move into cloned repository (__/mnt/etc/nixos/<username>__)
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
      - __Ctrl - Alt - F1__
      - login as root
      - ```passwd <username>```
      - __Ctrl - Alt - F7__
      - login as user
4. Remove extra configs to avoid problems rebuilding
```bash
sudo rm /etc/nixos/configuration.nix
sudo rm /etc/nixos/hardware_configuration.nix
```

5. Rebuilds:
```bash
sudo nixos-rebuild switch --flake <config path>#probook
```

6. Check out:
- ./modules/services/sxkhd for hotkeys
- ./hosts/configuration.nix to change programs list
- ./modules/desktops/polybar to configure polybar on multiple screens as you need it 
