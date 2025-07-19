{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    programs.spicetify = {
      enable = true;
      theme = "catppuccin-mocha";
      colorScheme = "lavender";

      enabledExtensions = with pkgs.spicetifyExtensions; [
        adblock
        hidePodcasts
        shuffle
      ];
    };
  };
}
