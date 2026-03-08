{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    services.dunst = {
      enable = true;

      settings = {
        global = {
          # Geometry
          width = 320;
          height = 150;
          padding = 14;
          horizontal_padding = 16;
          text_icon_padding = 12;
          gap_size = 8;
          origin = "top-right";
          offset = "30x30";

          # Appearance
          corner_radius = 14;
          frame_width = 2;
          font = "${config.stylix.fonts.sansSerif.name} 13";

          # Icons
          icon_position = "left";
          min_icon_size = 32;
          max_icon_size = 48;
        };

        urgency_low = {
          background = "#1e1e2e99";
          foreground = "#cdd6f4";
          frame_color = "#313244";
        };
        urgency_normal = {
          background = "#1e1e2e99";
          foreground = "#cdd6f4";
          frame_color = "#313244";
        };
        urgency_critical = {
          background = "#1e1e2ecc";
          foreground = "#f38ba8";
          frame_color = "#f38ba8";
        };
      };
    };
  };
}
