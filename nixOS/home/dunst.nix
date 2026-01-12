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
          width = 280;
          origin = "top-right";
          offset = "30x30";

          # Appearance
          corner_radius = 10;
          frame_width = 2;
          gap_size = 5;

          # Icons
          icon_position = "left";
          min_icon_size = 32;
          max_icon_size = 64;
        };
      };
    };
  };
}
