{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    programs.waybar = lib.mkForce {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 24;
          spacing = 4;
          margin-top = 6;
          margin-left = 8;
          margin-right = 8;
          modules-left = ["hyprland/workspaces" "tray"];
          modules-center = ["clock"];
          modules-right = [
            "temperature"
            "cpu"
            "memory"
            "disk"
            "pulseaudio"
            "network"
            "battery"
            "custom/power"
          ];
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              urgent = "";
              default = "";
            };
            ignore-workspaces = ["6" "7" "8" "9" "10" "11" "12"];
          };
          "tray" = {
            spacing = 10;
            icon-size = 20;
          };
          "clock" = {
            tooltip-format = "<big>{:%d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
            format = "󰅐  {:%I:%M %p     󰸗  %a, %d/%m/%Y}";
          };
          "cpu" = {
            format = "{usage}% ";
            interval = 3;
          };
          "memory" = {
            format = "{}% ";
            interval = 3;
          };
          "disk" = {
            format = "{percentage_used}% 󱛟";
            interval = 300;
            path = "/";
          };
          "temperature" = {
            format = "{temperatureC}°C 󱃃";
            interval = 3;
            hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            interval = 60;
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% 󰂄";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          "custom/power" = {
            format = "";
            on-click = "wlogout";
            tooltip = false;
          };
          "network" = {
            format-wifi = "{signalStrength}% 󰤨";
            format-ethernet = "󰈀";
            tooltip-format = "{essid} via {gwaddr}";
            format-linked = "{ifname} (No IP)";
            format-disconnected = "Disconnected 󰤭";
            format-alt = "{ipaddr}";
          };
          "pulseaudio" = {
            format = "{volume}% {icon}";
            format-muted = "{volume}% ";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
              default = ["" "" ""];
            };
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          };
        };
      };
      style = ''
        window#waybar {
          background: transparent;
        }
        .modules-left, .modules-center, .modules-right {
          min-height: 24px;
          border-radius: 10px;
          padding: 0.5rem 1rem;
          background: alpha(@theme_bg_color, 0.30);
          border: 1px solid alpha(@theme_fg_color, 0.15);
        }
        #workspaces button {
          min-height: 0;
          padding: 0 0.5rem;
          margin: 0;
          border-radius: 10px;
          transition: all 0.2s ease;
        }
        #workspaces button.active {
          color: @theme_selected_fg_color;
          background: alpha(@theme_selected_bg_color, 0.5);
        }
        #workspaces button.urgent {
          background: @warning_color;
        }
        #clock,
        #battery,
        #cpu,
        #memory,
        #disk,
        #temperature,
        #network,
        #tray {
          padding: 0 0.7rem;
        }
        #pulseaudio {
          color: @theme_fg_color;
          background: transparent;
          padding: 0 0.7rem;
        }
        #pulseaudio:hover {
          color: @theme_selected_bg_color;
          background: transparent;
          padding: 0 0.7rem;
        }
        #custom-power {
          color: @theme_fg_color;
          background: transparent;
          padding: 0 0.7rem;
        }
        #custom-power:hover {
          color: @theme_selected_bg_color;
          background: transparent;
          padding: 0 0.7rem;
        }
        #battery.charging, #battery.plugged {
          color: @success_color;
        }
        #battery.critical:not(.charging) {
          color: @error_color;
        }
        #pulseaudio.muted {
          opacity: 0.5;
        }
      '';
    };
  };
}
