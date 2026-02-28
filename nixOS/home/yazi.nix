{
  home-manager.users.sasdelli = {
    inputs,
    pkgs,
    config,
    lib,
    ...
  }: {
    programs.yazi = {
      enable = true;
      package = inputs.yazi-pinned.packages.${pkgs.stdenv.hostPlatform.system}.default;
      keymap = {
        mgr.prepend_keymap = [
          {
            on = ["z"];
            run = "plugin zoxide";
            desc = "Jump to a directory using zoxide";
          }
          {
            on = ["Z"];
            run = "plugin fzf";
            desc = "Jump to a file using fzf";
          }
        ];
      };
    };
  };
}
