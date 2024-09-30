{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    # Waybar configuration
    programs.waybar = lib.mkForce {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          spacing = 4;
          modules-left = ["hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = ["tray" "cpu" "memory" "pulseaudio" "network" "battery"];

          "hyprland/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              urgent = " ";
              focused = " ";
              default = " ";
            };
          };

          "tray" = {
            spacing = 10;
          };

          "clock" = {
            tooltip-format = "<big>{:%d. %B %Y}</big>\n<tt><small>{calendar}</small></tt>";
            format-alt = "{:%d.%m.%y}";
            on-click-right = "gnome-calendar";
            on-click-middle = "gnome-clocks";
          };

          "cpu" = {
            format = "{usage}%  ";
            tooltip = false;
          };

          "memory" = {
            format = "{}%  ";
          };

          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon}";
            format-charging = "{capacity}%  ";
            format-plugged = "{capacity}%   ";
            format-alt = "{time} {icon}";
            format-icons = [" " " " " " " " " "];
          };

          "network" = {
            format-wifi = "{essid} ({signalStrength}%)  ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠ ";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };

          "pulseaudio" = {
            format = "{volume}% {icon}";
            format-muted = "{volume}%  ";
            format-source = "{volume}% ";
            format-source-muted = " ";
            format-icons = {
              default = ["" " " " "];
            };
            on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          };
        };
      };
    };
  };
}
