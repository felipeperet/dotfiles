{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    programs.rofi = {
      enable = true;
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
        base = "30, 30, 46";
        text = "205, 214, 244";
        blue = "137, 180, 250";
        surface0 = "49, 50, 68";
      in {
        "*" = {
          background-color = lib.mkForce (mkLiteral "rgba(0, 0, 0, 0)");
          text-color = lib.mkForce (mkLiteral "rgba(${text}, 1.0)");
        };
        window = {
          background-color = lib.mkForce (mkLiteral "rgba(${base}, 0.6)");
          width = lib.mkForce (mkLiteral "50%");
          location = lib.mkForce (mkLiteral "center");
          anchor = lib.mkForce (mkLiteral "center");
          border-radius = lib.mkForce (mkLiteral "20px");
          border = lib.mkForce (mkLiteral "1px");
          border-color = lib.mkForce (mkLiteral "rgba(${text}, 0.15)");
        };
        mainbox = {
          background-color = lib.mkForce (mkLiteral "rgba(${base}, 0.0)");
          padding = lib.mkForce (mkLiteral "40px");
        };
        inputbar = {
          children = lib.mkForce [(mkLiteral "entry")];
          background-color = lib.mkForce (mkLiteral "rgba(${surface0}, 0.5)");
          padding = lib.mkForce (mkLiteral "20px");
          border-radius = lib.mkForce (mkLiteral "15px");
          margin = lib.mkForce (mkLiteral "0 0 20px 0");
        };
        entry = {
          padding = lib.mkForce (mkLiteral "10px");
          background-color = lib.mkForce (mkLiteral "rgba(0, 0, 0, 0)");
          text-color = lib.mkForce (mkLiteral "rgba(${text}, 1.0)");
          placeholder = lib.mkForce "Search...";
          placeholder-color = lib.mkForce (mkLiteral "rgba(${text}, 0.4)");
        };
        listview = {
          background-color = lib.mkForce (mkLiteral "rgba(0, 0, 0, 0)");
          spacing = lib.mkForce (mkLiteral "10px");
          lines = lib.mkForce 6;
        };
        element = {
          padding = lib.mkForce (mkLiteral "15px");
          border-radius = lib.mkForce (mkLiteral "10px");
          background-color = lib.mkForce (mkLiteral "rgba(0, 0, 0, 0)");
          text-color = lib.mkForce (mkLiteral "rgba(${text}, 1.0)");
        };
        "element selected" = {
          background-color = lib.mkForce (mkLiteral "rgba(${blue}, 0.12)");
          border-radius = lib.mkForce (mkLiteral "10px");
        };
        element-icon = {
          size = lib.mkForce (mkLiteral "3em");
          margin = lib.mkForce (mkLiteral "0 15px 0 0");
        };
        element-text = {
          text-color = lib.mkForce (mkLiteral "rgba(${text}, 1.0)");
        };
        "element-text selected" = {
          text-color = lib.mkForce (mkLiteral "rgba(${text}, 1.0)");
        };
      };
    };
  };
}
