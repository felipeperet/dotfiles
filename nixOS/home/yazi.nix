{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    programs.yazi = {
      enable = true;
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
