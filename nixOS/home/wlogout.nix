{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    programs.wlogout = {
      enable = true;
      style =
        config.lib.stylix.css {
        };
    };
  };
}
