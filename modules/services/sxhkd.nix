#
#  Hotkey Daemon
#

{ config, lib, vars, ... }:

{
  config = lib.mkIf (config.x11wm.enable) {
    home-manager.users.${vars.user} = {
      services = {
        sxhkd = {
          enable = true;
          keybindings = {
            
            # # # # # Apps
            # Launch terminal
            "super + Return" = "${vars.terminal}";
            # Show apps menu
            "super + d" = "rofi -show drun";
            # Launch apps
            "super + shift + f" = "firefox";
            "super + shift + n" = "thunar";
            "super + shift + p" = "pavucontrol";
            "super + shift + t" = "telegram-desktop";
            "super + shift + c" = "codium";
            "super + shift + m" = "qsynth";
            # Screenshot
            "Print" = "flameshot gui";
            # Close/kill
            "ctrl + shift + super + {c,k}" = "bspc node -{c,k}";

            # # # # # Window Settings
            # Change window mode floating -> tiled
            "super + space" = "bspc node -t \"~\"{floating,tiled}";
            # Change window focus
            "alt + {_,shift + }Tab" = "bspc node -f {next.local,prev.local}";
            # Change desktop (super) and
            # Send focus window to some (1-9) desktop (super + shift)
            "super + {_,shift + }{1-9,0}" = "bspc {desktop -f,node -d} '^{1-9,10}'";
            # Move windows along the screen
            "super + {_,shift +}{Left,Right,Up,Down}" = "bspc node -{f,s} {west,east,north,south}";
            # Control - Resize
            "control + {Left,Down,Up,Right}" = ''
              bspc node -z {left -20 0 || bspc node -z right -20 0, \
                            bottom 0 20 || bspc node -z top 0 20,\
                            top 0 -20 || bspc node -z bottom 0 -20,\
                            right 20 0 || bspc node -z left 20 0}
            '';
            # # # # # XF86 Keys
            "XF86AudioMute" = "pactl list sinks | grep -q Mute:.no && pactl set-sink-mute 0 1 || pactl set-sink-mute 0 0";
            "XF86AudioRaiseVolume" = "pactl -- set-sink-volume 0 +10%";
            "XF86AudioLowerVolume" = "pactl -- set-sink-volume 0 -10%";
            "XF86AudioMicMute" = "pactl set-source-mute 1 toggle";
            "XF86MonBrightnessDown" = "light -U  5";
            "XF86MonBrightnessUp" = "light -A 5";
          
            
            # Previous settings (skip these lines)
            
            
            # # Apps
            # "super + Return" = "${vars.terminal}";
            # "super + space" = "rofi -show drun -show-icons";
            # "super + e" = "pcmanfm";
            # "Print" = "flameshot gui";

            # # Bspwm
            # "super + {q,k}" = "bspc node -{c,k}";
            # "super + Escape" = "bspc quit";
            # "super + r" = "bspc wm -r";

            # # Super - Nodes
            # "super + {_,shift +}{Left,Right,Up,Down}" = "bspc node -{f,s} {west,east,north,south}";
            # "super + m" = "bspc desktop -l next";
            # "super + {t,h,f}" = "bspc node -t '~{tiled,floating,fullscreen}'";
            # "super + g" = "bspc node -s biggest.window";

            # # Alt - Move workspaces
            # "alt + {Left,Right}" = "bspc desktop -f {prev,next}.local";
            # "alt + {_,shift +}{1-9,0}" = "bspc {desktop -f,node -d} '{1-9,10}'";
            # "alt + shift + {Left,Right}" = "bspc node -d {prev,next}.local --follow";

            # # Control - Resize
            # "control + {Left,Down,Up,Right}" = ''
            #   bspc node -z {left -20 0 || bspc node -z right -20 0, \
            #                 bottom 0 20 || bspc node -z top 0 20,\
            #                 top 0 -20 || bspc node -z bottom 0 -20,\
            #                 right 20 0 || bspc node -z left 20 0}
            # '';

          };
        };
      };
    };
  };
}
