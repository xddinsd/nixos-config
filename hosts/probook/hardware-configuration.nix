#
# Hardware settings for HP ProBook 650 G1 15.6" Laptop
# Dual boot active. Windows @ sda4 / NixOS @ sda5
#
# flake.nix
#  └─ ./hosts
#      └─ ./probook
#          ├─ default.nix
#          └─ hardware-configuration.nix *
#
# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
#

{ config, lib, modulesPath, host, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/4e5ea9c2-c620-4d21-9fbc-d7296ade110c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/ECA1-D8DA";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking = with host; {
    hostName = hostName;
    networkmanager.enable = true;
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
