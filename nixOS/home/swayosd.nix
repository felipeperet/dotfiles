{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    services.swayosd = {
      enable = true;
      topMargin = 0.5;
      styleSheet = ''
        window {
          background: transparent;
        }

        #osd {
          background: rgba(30, 30, 46, 0.85);
          border: 1px solid rgba(205, 214, 244, 0.15);
          border-radius: 14px;
          padding: 16px 24px;
          min-width: 300px;
        }

        image, label {
          color: #cdd6f4;
        }

        progressbar {
          min-height: 6px;
          border-radius: 3px;
        }

        progressbar > trough {
          background: rgba(69, 71, 90, 0.6);
          border-radius: 3px;
          min-height: 6px;
        }

        progressbar > trough > progress {
          background: #89b4fa;
          border-radius: 3px;
          min-height: 6px;
        }
      '';
    };
  };
}
