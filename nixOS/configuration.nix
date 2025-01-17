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
  ...
}: {
  system.stateVersion = "25.05";

  home-manager = {
    users.sasdelli.home.stateVersion = "25.05";
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

  nixpkgs = {
    # Allow unfree packages.
    config.allowUnfree = true;

    # Permitted Insecure Packages.
    config.permittedInsecurePackages = [
    ];
  };

  # Stylix Configuration.
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-material-dark-medium.yaml";
    image = /home/sasdelli/Wallpapers/cyber-gruv.png;
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

  # Chaotic-Nyx Configuration.
  chaotic.mesa-git.enable = false;

  # Setting a specific Kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Bootloader.
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
    };
    efi.canTouchEfiVariables = true;
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

    nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      open = false; # Use closed-source drivers.
    };

    # Enable Bluetooth.
    bluetooth = {
      enable = true;
      powerOnBoot = true;
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
    pkgs.nerd-fonts.victor-mono
    pkgs.nerd-fonts.fira-code
    monaspace
  ];

  xdg = {
    portal.enable = true;
    portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # List services that you want to enable:
  virtualisation.docker.enable = true;
}
