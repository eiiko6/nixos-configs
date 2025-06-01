{ config, pkgs, ... }:

{
  programs.hyprland = {
    enable = true;

    # Environment variables (from env_var.conf + env_var_nvidia.conf)
    environmentVariables = {
      XCURSOR_PATH = "~/.local/share/icons/";
      XCURSOR_THEME = "BreezeX-RosePine-Linux";
      XCURSOR_SIZE = "30";

      HYPRCURSOR_THEME = "rose-pine-hyprcursor";
      HYPRCURSOR_SIZE = "30";

      GTK_THEME = "Graphite-Dark"; # overridden in appearance later

      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "Hyprland";

      # Nvidia specific (only set if you have nvidia, check your nix config)
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      NVD_BACKEND = "direct";
    };

    # General appearance config (appearance.conf + theme overrides)
    config = ''
      general {
        gaps_in = 5
        gaps_out = 15
        border_size = 2
        col.active_border = rgba(965ff599)
        col.inactive_border = rgba(8a51ed55)

        layout = dwindle

        env = GTK_THEME,Adwaita-dark
      }

      misc {
        disable_hyprland_logo = yes
      }

      decoration {
        rounding = 20

        blur {
          enabled = true
          size = 0
          passes = 6
          new_optimizations = true
          brightness = 1
          contrast = 1
          noise = 0.05
          ignore_opacity = true
          popups = true
        }

        shadow {
          enabled = false
        }

        blurls = lockscreen,wofi
      }

      source = ~/.cache/wal/colors-hyprland.conf
    '';

    # Hypridle config (idle timeouts and actions)
    hypridleConfig = ''
      general {
        lock_cmd = /home/strawberries/.config/hypr/scripts/lock.sh
        before_sleep_cmd = /home/strawberries/.config/hypr/scripts/lock.sh
        after_sleep_cmd = hyprctl dispatch dpms on
      }

      listener {
        timeout = 150
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
      }

      listener {
        timeout = 300
        on-timeout = /home/strawberries/.config/hypr/scripts/lock.sh
      }

      listener {
        timeout = 1800
        on-timeout = systemctl suspend
      }
    '';

    # Cursor config (nvidia specific)
    cursorConfig = ''
      no_hardware_cursors = true
    '';

    # Bindings config (bindings.conf)
    bindingsConfig = ''
      set $mainMod CONTROL
      set $terminal kitty

      bind = $mainMod, C, killactive
      bind = $mainMod, F, fullscreen
      bind = $mainMod, P, pseudo
      bind = $mainMod, U, togglesplit
      bind = $mainMod SHIFT, M, exit
      bind = $mainMod, R, exec, hyprctl reload && notify-send "Hyprland reloaded!"

      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d

      bind = $mainMod SHIFT, H, swapwindow, l
      bind = $mainMod SHIFT, L, swapwindow, r
      bind = $mainMod SHIFT, K, swapwindow, u
      bind = $mainMod SHIFT, J, swapwindow, d

      bind = $mainMod CONTROL, H, resizeactive, -45 0
      bind = $mainMod CONTROL, L, resizeactive, 45 0
      bind = $mainMod CONTROL, K, resizeactive, 0 -45
      bind = $mainMod CONTROL, J, resizeactive, 0 45

      # Workspaces
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      bind = $mainMod, Tab, focusmonitor, +1
      bind = $mainMod SHIFT, Tab, focusmonitor, -1

      bind = $mainMod, V, togglefloating
      bind = $mainMod SHIFT, C, setfloating
      bind = $mainMod SHIFT, C, resizeactive, exact 73% 73%
      bind = $mainMod SHIFT, C, centerwindow

      # Launch utilities
      bind = $mainMod, SPACE, exec, wofi
      bind = $mainMod, X, exec, /home/strawberries/.config/hypr/scripts/lock.sh
      bind = ($mainMod)_SHIFT, P, exec, hyprpicker -a -f hex
      bind = ($mainMod)_SHIFT, V, exec, cliphist list | wofi -dmenu -W 800 -H 300 --location center | cliphist decode | wl-copy
      bind = $mainMod, S, exec, /home/strawberries/.config/hypr/scripts/screenshot.sh
      bind = $mainMod SHIFT, S, exec, /home/strawberries/.config/hypr/scripts/screenshot.sh full
      bind = $mainMod, SEMICOLON, exec, ~/.config/scripts/palette/change-wallpaper-menu.sh

      # Launch apps
      bind = $mainMod, Q, exec, $terminal
      bind = $mainMod SHIFT, Q, exec, env KITTY_WINDOW_CLASS=clean_fish kitty
      bind = $mainMod, T, exec, $secondaryTerminal
      bind = $mainMod, E, exec, $fileManager
      bind = $mainMod, I, exec, $browser
      bind = $mainMod, O, exec, gtk-launch obsidian
      bind = $mainMod, D, exec, qalculate-gtk

      # Scripts
      bind = $mainMod, N, exec, /home/strawberries/.config/hypr/scripts/waybar-toggle.sh
      bind = $mainMod, G, exec, /home/strawberries/.config/hypr/scripts/gamemode.sh
      bind = $mainMod, B, exec, /home/strawberries/.config/hypr/scripts/idle.sh

      # Media binds
      bind = , xf86audioraisevolume, exec, /home/strawberries/.config/hypr/scripts/volume.sh --inc
      bind = , xf86audiolowervolume, exec, /home/strawberries/.config/hypr/scripts/volume.sh --dec
      bind = , xf86AudioMicMute, exec, /home/strawberries/.config/hypr/scripts/volume.sh --toggle-mic
      bind = , xf86audioMute, exec, /home/strawberries/.config/hypr/scripts/volume.sh --toggle
      bind = , xf86MonBrightnessDown, exec, /home/strawberries/.config/hypr/scripts/brightness.sh --dec
      bind = , xf86MonBrightnessUp, exec, /home/strawberries/.config/hypr/scripts/brightness.sh --inc

      # Misc
      bind = , PrintScreen, exec, /home/strawberries/.config/hypr/scripts/screenshot.sh
      bind = , Shift+PrintScreen, exec, /home/strawberries/.config/hypr/scripts/screenshot.sh full
    '';
  };
}
