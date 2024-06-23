#
#  Specific system configuration settings for probook
#
#  flake.nix
#   ├─ ./hosts
#   │   ├─ default.nix
#   │   └─ ./probook
#   │        ├─ default.nix *
#   │        └─ hardware-configuration.nix
#   └─ ./modules
#       └─ ./desktops
#           ├─ bspwm.nix
#           └─ ./virtualisation
#               └─ docker.nix
#

{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/desktops/virtualisation/docker.nix
  ];

  boot = {
    consoleLogLevel = 3;
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 2;
      };
      efi = {
        canTouchEfiVariables = true;
      };
      timeout = 5;
    };
  };

  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.sane-airscan ];
  };

  laptop.enable = true;
  bspwm.enable = true;
  networking.networkmanager.enable = true;

  environment = {
    systemPackages = with pkgs; [
      simple-scan # Scanning
    ];
  };

  programs.light.enable = true;

  services = {
    printing = {
      enable = true;
      drivers = [ pkgs.cnijfilter2 ]; # Canon TS5300
    };
  };
}
