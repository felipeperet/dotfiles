#  _   _ _______   _______ _____
# | \ | |_   _\ \ / /  _  /  ___|
# |  \| | | |  \ V /| | | \ `--.
# | . ` | | |  /   \| | | |`--. \
# | |\  |_| |_/ /^\ \ \_/ /\__/ /
# \_| \_/\___/\/   \/\___/\____/
################################################################################
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  system.stateVersion = "25.05";

  home-manager = {
    users.sasdelli.home.stateVersion = "25.05";
    users.sasdelli.imports = [inputs.spicetify-nix.homeManagerModules.default];
    backupFileExtension = "backup";
  };

  imports = [
    # Hardware settings
    ./hardware-configuration.nix
    # Users
    ./users/sasdelli.nix
    # Services and Programs
    ./modules/services.nix
    ./modules/programs.nix
    # Home-Manager
    ./home/kitty.nix
    ./home/rofi.nix
    ./home/waybar.nix
    ./home/yazi.nix
    ./home/spicetify.nix
    # Nix Packages
    # List packages installed in system profile. To search, run:
    # $ nix search wget
    ./packages/terminals.nix
    ./packages/editors.nix
    ./packages/browsers.nix
    ./packages/hyprland.nix
    ./packages/media-audio.nix
    ./packages/cli.nix
    ./packages/gui.nix
    ./packages/games.nix
    ./packages/utils.nix
    ./packages/programming.nix
  ];

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      substituters = ["https://cache.nixos.org"];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Stylix Configuration.
  stylix = {
    enable = true;
    # targets.spicetify.enable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    image = /home/sasdelli/Wallpapers/Gruvbox/gruv.png;
    polarity = "dark";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 30;
    };
    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      monospace = {
        package = pkgs.nerd-fonts.victor-mono;
        name = "VictorMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 13;
        terminal = 18;
        desktop = 13;
        popups = 13;
      };
    };
  };

  # Setting a specific Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
    systemd-boot.enable = false;
  };

  # Define your hostname.
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Allow non-root users to adjust screen brightness using 'light'.
  security.wrappers = {
    light = {
      source = "${pkgs.light}/bin/light";
      owner = "root";
      group = "root";
      setuid = true;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";

    supportedLocales = [
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "pt_BR.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };
  };

  hardware = {
    # Enable Graphics Cards.
    graphics.enable = true;
    graphics.enable32Bit = true;

    # Enable Bluetooth.
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    # Enable i2c (for OpenRGB).
    i2c.enable = true;
  };

  # Enable DeepCool AK620 Digital monitoring.
  systemd.services.deepcool-digital = {
    description = "DeepCool Digital";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/home/sasdelli/scripts/deepcool-digital-linux";
      Type = "simple";
      User = "sasdelli";
    };
  };

  # Enable Redlib.
  systemd.services.redlib = {
    description = "Redlib - Alternative Reddit frontend";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.redlib}/bin/redlib";
      Restart = "on-failure";
      RestartSec = 5;
      User = "sasdelli";
      NoNewPrivileges = true;
      ProtectSystem = "strict";
      ProtectHome = true;
      PrivateTmp = true;
    };
  };

  environment = {
    variables = {
      GDK_BACKEND = "wayland";
    };

    sessionVariables = {
      # If your cursor becomes invisible.
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };

  # Configuring fonts.
  fonts.packages = with pkgs; [
    nerd-fonts.victor-mono
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
  ];

  xdg = {
    portal.enable = true;
    portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # List services that you want to enable:
  virtualisation.docker.enable = true;
}
