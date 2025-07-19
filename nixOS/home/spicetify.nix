{
  inputs,
  lib,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    theme = lib.mkForce spicePkgs.themes.catppuccin;
    colorScheme = lib.mkForce "mocha";

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
  };
}
