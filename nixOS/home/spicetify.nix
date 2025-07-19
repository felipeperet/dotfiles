{
  inputs,
  lib,
  ...
}: {
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    programs.spicetify = {
      enable = true;
      # theme = lib.mkForce spicePkgs.themes.catppuccin;
      # colorScheme = lib.mkForce "lavender";

      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
    };
  };
}
