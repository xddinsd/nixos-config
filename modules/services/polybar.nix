#
#  Bar
#

{ config, lib, pkgs, vars, host, ... }:

with host;
let
  polybar = pkgs.polybar.override {
    alsaSupport = true;
    pulseSupport = true;
  };
in
{
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${vars.user} = {
      services = {
        polybar = {
          enable = true;
          script = ''
            # killall -q polybar &
            # while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
            # polybar main &
            # polybar sec &
          ''; # Run Polybar on Startup
          package = polybar;
          config = {
            "bar/main" = {
              monitor = mainMonitor;
              width = "98%";
              height = 26;
              background = "#1e222a";
              foreground = "#ccffffff";

              padding-right = 0;
              padding-left = 1;
			  bottom = false;
			  
			  border-top-size = 7;
			  border-bottom-size = 7;
			  border-top-color ="#1e222a";
			  border-bottom-color = "#1e222a";
			  fixed-center = true;
			  line-size = 3;
			  
              module-margin-left = 1;

              font-0 = "JetBrainsMono Nerd Font:style=Bold:pixelsize=13;3";
              font-1 = "JetBrainsMono Nerd Font:size=18;5";
              font-2 = "FontAwesome6Free:style=Regular:size=13";
              font-3 = "FontAwesome6Brands:style=Regular:size=13";
              font-4 = "FiraCodeNerdFont:size=15";

              modules-left = "logo bspwm";
              modules-center = "memory pad cpu pad temperature";
              modules-right = "battery pad volume pad  backlight date";

              tray-position = "right";
              tray-detached = "false";
              tray-padding = 5;

              wm-restack = "bspwm";
            };
            "bar/sec" = {
              monitor = "${secondMonitor}";
              width = "100%";
              height = 15;
              background = "#00000000";
              foreground = "#ccffffff";

              offset-y = 2;
              spacing = "1.5";
              padding-right = 2;
              module-margin-left = 1;

              font-0 = "SourceCodePro:size=10";
              font-1 = "FontAwesome6Free:style=Solid:size=8";
              font-2 = "FontAwesome6Free:style=Regular:size=8";
              font-3 = "FontAwesome6Brands:style=Regular:size=8";
              font-4 = "FiraCodeNerdFont:size=10";
              modules-left = "logo bspwm";
              modules-right = "memory cpu pad sink volume pad date";

              wm-restack = "bspwm";
            };
            "bar/thi" = {
              monitor = "${thirdMonitor}";
              width = "100%";
              height = 15;
              background = "#00000000";
              foreground = "#ccffffff";

              tray-position = "right";
              tray-padding = 5;

              border-top-size = 7;
              border-bottom-size = 7;
              border-top-color = "#00000000";
              border-bottom-color = "#00000000";

              offset-x = "1%";
              offset-y = "0.5%";
              padding-left = 1;
              padding-right = 0;
              module-margin-left = 1;

              font-0 = "SourceCodePro:size=10";
              font-1 = "FontAwesome6Free:style=Solid:size=8";
              font-2 = "FontAwesome6Free:style=Regular:size=8";
              font-3 = "FontAwesome6Brands:style=Regular:size=8";
              font-4 = "FiraCodeNerdFont:size=10";
              modules-left = "logo bspwm";
              modules-right = "memory cpu pad sink volume pad date";

              wm-restack = "bspwm";
            };
            "module/memory" = {
              type = "internal/memory";
              format = "<label>";
              format-foreground = "#d19a66";
              label = "  %percentage_used%%";
            };
            "module/cpu" = {
              type = "internal/cpu";
              interval = 1;
              format = "<label>";
              format-foreground = "#9498f0";
              label = "  %percentage%%";
            };
            "module/volume" = {
              type = "internal/pulseaudio";
              interval = 2;
              use-ui-max = "false";
              format-volume = "<ramp-volume>  <label-volume>";
              format-foreground = "#d35f5e";
              label-muted = "  muted";

              ramp-volume-0 = "";
              ramp-volume-1 = "";
              ramp-volume-2 = "";

              click-right = "${pkgs.pavucontrol}/bin/pavucontrol";
            };
            "module/backlight" = {
              type = "internal/backlight";
              card = "intel_backlight";
              format = "<ramp> <bar>";

              ramp-0 = "";
              ramp-1 = "";
              ramp-2 = "";

              bar-width = 10;
              bar-indicator = "|";
              bar-indicator-font = 3;
              bar-indicator-foreground = "#61afef";
              bar-fill = "─";
              bar-fill-font = 3;
              bar-fill-foreground = "#61afef";
              bar-empty = "─";
              bar-empty-font = 3;
              bar-empty-foreground = "#44";
            };
            "module/battery" = {
              type = "internal/battery";
              full-at = 95;
              low-at = 10;

              battery = "BAT1";
              adapter = "ACAD";
              poll-interval = 5;

              label-full = "%percentage%%";
              label-charging = "%percentage%%";
              label-discharging = "%percentage%%";

              format-charging = "<animation-charging> <label-charging>    ";
              format-discharging = "<ramp-capacity> <label-discharging>    ";
              format-full = "<ramp-capacity> <label-full>    ";

              ramp-capacity-0 = "";
              ramp-capacity-0-foreground = "#a0e8a2";
              ramp-capacity-1 = "";
              ramp-capacity-1-foreground = "#a0e8a2";
              ramp-capacity-2 = "";
              ramp-capacity-3 = "";
              ramp-capacity-4 = "";

              bar-capacity-width = 10;
              bar-capacity-format = "%{+u}%{+o}%fill%%empty%%{-u}%{-o}";
              bar-capacity-fill = "█";
              bar-capacity-fill-foreground = "#a0e8a2";
              bar-capacity-fill-font = 3;
              bar-capacity-empty = "█";
              bar-capacity-empty-font = 3;
              bar-capacity-empty-foreground = "#44ffffff";

              animation-charging-0 = "";
              animation-charging-1 = "";
              animation-charging-2 = "";
              animation-charging-3 = "";
              animation-charging-4 = "";
              animation-charging-framerate = 750;
            };
            "module/temperature" = {
              type = "internal/temperature";
              thermal-zone = 0;
              warn-temperature = 70;

              format = "<ramp> <label>";
              format-warn = "<ramp> <label-warn>";
              format-padding = 0; 
              label = "%temperature%";
              label-warn = "%temperature%";
              ramp-0 = "";
              ramp-foreground = "#a4ebf3";
            };

            "module/date" = {
              type = "internal/date";
              date = "%%{F#fff}%d-%m-%Y%%{F-} %%{F#f2d17f}%H:%M%%{F-}";
            };
            "module/bspwm" = {
              type = "internal/bspwm";
              
              pin-workspaces = true;
              inline-mode = true;
              enable-click = true;
              enable-scroll = true;
              reverse-scroll = false;
              
              format = "<label-state>";
              ws-icon-0 = "1;%{F#F9DE8F}1";
              ws-icon-1 = "2;%{F#ff9b93}2";
              ws-icon-2 = "3;%{F#95e1d3}3";
              ws-icon-3 = "4;%{F#81A1C1}4";
              ws-icon-4 = "5;%{F#A3BE8C}5";
              ws-icon-5 = "6;%{F#F9DE8F}6";
              ws-icon-6 = "7;%{F#ff9b93}7";
              
              label-separator = "";
              label-separator-background = "#2b2f37";
              
              label-focused =  "%icon%";
              label-focused-foreground = "#ccffffff";
              label-focused-underline =  "#565c64";
              label-focused-padding = 1;
              label-focused-background = "#2b2f37";
              
              label-occupied = "%icon%";
              label-occupied-foreground = "#646870";
              label-occupied-background = "#2b2f37";
              label-occupied-padding = 1;
              
              label-empty = "%icon%";
              label-empty-foreground =  "#ccffffff";
              label-empty-padding = 1;
              label-empty-background = "#2b2f37";
              
              label-urgent = "%icon%";
              label-urgent-foreground = "#88C0D0";
              label-urgent-background = "#2b2f37";
              label-urgent-padding = 1;
            };
            "module/title" = {
              type = "internal/xwindow";
              format = "<label>";
              format-background = "#00000000";
              format-foreground = "#ccffffff";
              label = "%title%";
              label-maxlen = 75;
              label-empty = "";
              label-empty-foreground = "#ccffffff";
            };

            "module/pad" = {
              type = "custom/text";
              content = "    ";
            };
            "module/mic" = {
              type = "custom/script";
              interval = 1;
              tail = "true";
              exec = "~/.config/polybar/script/mic.sh status";
              click-left = "~/.config/polybar/script/mic.sh toggle";
            };
            "module/sink" = {
              type = "custom/script";
              interval = 1;
              tail = "true";
              exec = "~/.config/polybar/script/sink.sh status";
              click-left = "~/.config/polybar/script/sink.sh toggle";
            };
            "module/logo" = {
              type = "custom/menu";
              expand-right = true;

              label-open = " %{F#a7c7e7} ";
              label-close = " %{F#a7c7e7} ";
              label-separator = "|";
              format-spacing = "1";

              menu-0-0 = "";
              menu-0-0-exec = "menu-open-1";
              menu-0-1 = "";
              menu-0-1-exec = "menu-open-2";

              menu-1-0 = "";
              menu-1-0-exec = "sleep 0.5; bspc quit";
              menu-1-1 = "";
              menu-1-1-exec = "sleep 0.5; xset dpms force standby";
              menu-1-2 = "";
              menu-1-2-exec = "sleep 0.5; systemctl suspend";
              menu-1-3 = "";
              menu-1-3-exec = "sleep 0.5; systemctl poweroff";
              menu-1-4 = "";
              menu-1-4-exec = "sleep 0.5; systemctl reboot";

              menu-2-0 = "";
              menu-2-0-exec = "${vars.terminal} &";
              menu-2-1 = "";
              menu-2-1-exec = "firefox &";
              menu-2-2 = "";
              menu-2-2-exec = "emacs &";
              menu-2-3 = "";
              menu-2-3-exec = "plexmediaplayer &";
              menu-2-4 = "";
              menu-2-4-exec = "flatpak run com.obsproject.Studio &";
              menu-2-5 = "";
              menu-2-5-exec = "lutris &";
              menu-2-6 = "";
              menu-2-6-exec = "steam &";
            };
            "module/bluetooth" = {
              type = "custom/text";
              content = "";
              click-left = "${pkgs.blueman}/bin/blueman-manager";
            };
          };
        };
      };
      home.file.".config/polybar/script/mic.sh" = {
        text = ''
          #!/bin/sh

          case $1 in
              "status")
              #MUTED=$(pacmd list-sources | awk '/\*/,EOF {print}' | awk '/muted/ {print $2; exit}')
              #if [[ $MUTED = "no" ]]; then
              MUTED=$(awk -F"[][]" '/Left:/ { print $4 }' <(amixer sget Capture))
              if [[ $MUTED = "on" ]]; then
                  echo ''
              else
                  echo ''
              fi
              ;;
              "toggle")
              #ID=$(pacmd list-sources | grep "*\ index:" | cut -d' ' -f5)
              #pactl set-source-mute $ID toggle
              ${pkgs.alsa-utils}/bin/amixer set Capture toggle
              ;;
          esac
        '';
        executable = true;
      };
      home.file.".config/polybar/script/sink.sh" = {
        text = ''
          #!/bin/sh

          ID1=$(awk '/ Built-in Audio Analog Stereo/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | head -n 1)
          ID2=$(awk '/ S10 Bluetooth Speaker/ {sub(/.$/,"",$2); print $2 }' <(${pkgs.wireplumber}/bin/wpctl status) | sed -n 2p)

          HEAD=$(awk '/ Built-in Audio Analog Stereo/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | sed -n 2p)
          SPEAK=$(awk '/ S10 Bluetooth Speaker/ { print $2 }' <(${pkgs.wireplumber}/bin/wpctl status | grep "*") | head -n 1)

          case $1 in
              "status")
              if [[ $HEAD = "*" ]]; then
                  echo ''
              elif [[ $SPEAK = "*" ]]; then
                  echo '蓼'
              fi
              ;;
              "toggle")
              if [[ $HEAD = "*" ]]; then
                  ${pkgs.wireplumber}/bin/wpctl set-default $ID2
              elif [[ $SPEAK = "*" ]]; then
                  ${pkgs.wireplumber}/bin/wpctl set-default $ID1
              fi
              ;;
          esac
        '';
        executable = true;
      };
    };
  };
}
