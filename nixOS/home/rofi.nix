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
        element-icon = {
          size = mkLiteral "4ch";
        };

        window = {
          border-radius = mkLiteral "15px";
        };

        inputbar = {
          children = [(mkLiteral "entry")];
        };

        entry = {
          padding = mkLiteral "6px";
          margin = mkLiteral "20px 0px 0px 20px";
          border-radius = mkLiteral "15px";
        };
      };
    };
  };
}
