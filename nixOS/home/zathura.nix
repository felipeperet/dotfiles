{pkgs, ...}: {
  home-manager.users.sasdelli = {
    programs.zathura = {
      enable = true;
      package = pkgs.symlinkJoin {
        name = "zathura";
        paths = [pkgs.zathura];
        nativeBuildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/zathura \
            --set GDK_BACKEND x11
        '';
      };
      options = {
        recolor = false;
        index-fg = "#cdd6f4";
        index-bg = "#1e1e2e";
        index-active-fg = "#89b4fa";
        index-active-bg = "#313244";
        guioptions = "";
      };
    };
  };
}
