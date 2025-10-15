{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    # Rofi configuration
    programs.rofi = {
      enable = true;

      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        window = {
          background-color = lib.mkForce (mkLiteral "rgba(0, 0, 0, 0.4)");
          width = lib.mkForce (mkLiteral "50%");
          location = lib.mkForce (mkLiteral "center");
          anchor = lib.mkForce (mkLiteral "center");
          border-radius = lib.mkForce (mkLiteral "20px");
        };

        mainbox = {
          background-color = lib.mkForce (mkLiteral "rgba(20, 20, 20, 0.9)");
          padding = lib.mkForce (mkLiteral "40px");
        };

        inputbar = {
          children = lib.mkForce [(mkLiteral "entry")];
          background-color = lib.mkForce (mkLiteral "rgba(255, 255, 255, 0.1)");
          padding = lib.mkForce (mkLiteral "20px");
          border-radius = lib.mkForce (mkLiteral "15px");
          margin = lib.mkForce (mkLiteral "0 0 20px 0");
        };

        entry = {
          padding = lib.mkForce (mkLiteral "10px");
          background-color = lib.mkForce (mkLiteral "transparent");
          text-color = lib.mkForce (mkLiteral "rgba(255, 255, 255, 1.0)");
        };

        listview = {
          background-color = lib.mkForce (mkLiteral "transparent");
          spacing = lib.mkForce (mkLiteral "10px");
          lines = lib.mkForce 6;
        };

        element = {
          padding = lib.mkForce (mkLiteral "15px");
          border-radius = lib.mkForce (mkLiteral "10px");
          background-color = lib.mkForce (mkLiteral "transparent");
        };

        element-icon = {
          size = lib.mkForce (mkLiteral "3em");
          margin = lib.mkForce (mkLiteral "0 15px 0 0");
        };

        element-text = {
          text-color = lib.mkForce (mkLiteral "rgba(255, 255, 255, 0.9)");
        };
      };
    };
  };
}
