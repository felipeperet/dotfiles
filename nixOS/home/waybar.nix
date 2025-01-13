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
          height = 30;
          spacing = 4;
          margin-top = 6;
          margin-left = 8;
          margin-right = 8;
          modules-left = ["hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = ["tray" "temperature" "cpu" "memory" "disk" "pulseaudio" "network" "battery"];
          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              urgent = "";
              default = "";
            };
          };
          "tray" = {
            spacing = 10;
            icon-size = 18;
          };
          "clock" = {
            tooltip-format = "<big>{:%d %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
            format = "{:%H:%M}";
            format-alt = "{:%d/%m/%Y}";
            on-click-right = "gnome-calendar";
            on-click-middle = "gnome-clocks";
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
            format = "{temperatureC}°C {icon}";
            critical-threshold = 80;
            interval = 3;
            thermal-zone = 7;
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% 󰂄";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          };
          "network" = {
            format-wifi = "{signalStrength}% 󰤨";
            format-ethernet = "󰈀";
            tooltip-format = "{essid} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
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
          border-radius: 10px;
          padding: 0.5rem 1rem;
          background: @theme_bg_color;
        }
        #workspaces button {
          padding: 0 0.5rem;
          border-radius: 6px;
          transition: all 0.2s ease;
        }
        #workspaces button.active {
          background: @theme_selected_bg_color;
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
        #pulseaudio,
        #tray {
          padding: 0 0.7rem;
        }
        #battery.charging, #battery.plugged {
          color: @success_color;
        }
        #battery.critical:not(.charging) {
          color: @error_color;
        }
        #temperature.critical {
          color: @error_color;
        }
        #pulseaudio.muted {
          opacity: 0.5;
        }
      '';
    };
  };
}
