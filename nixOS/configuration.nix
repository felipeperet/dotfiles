# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # Define the overridden waybar package.
  customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
  });

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    settings = {
      substituters = [
        "https://hydra.iohk.io"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
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

  # Enable the KDE Plasma Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Enabling Graphics Cards
  hardware.opengl.enable = true;
  # hardware.nvidia.optimus_prime.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;

  # Configure xserver.
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" "nvidia" ];
    displayManager.gdm = {
        enable = true;
        wayland = true;
    };
    layout = "br";
    xkbVariant = "";
  };

  # Configure console keymap.
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth.
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable PostgreSQL
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sasdelli = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Felipe Sasdelli";
    extraGroups = [ "networkmanager" "wheel" "input"
                    "docker" "audio"
                  ];
    packages = with pkgs; [
      firefox
      neovim
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  environment.variables.GDK_BACKEND = "wayland";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty

    # Fonts
    font-awesome

    # Shell
    zsh

    # Editors
    vim
    neovim
    emacs
    emacsPackages.engrave-faces
    emacsPackages.ox-reveal

    # Browsers
    firefox
    google-chrome

    # Wayland + Hyprland
    customWaybar
    dunst
    libnotify
    rofi-wayland
    swww
    lxappearance-gtk2
    networkmanagerapplet
    blueberry

    # Audio
    pulseaudioFull
    pulsemixer
    mpd

    # CLI
    wget
    curl
    git
    direnv
    tree
    htop
    duf
    zip
    unzip
    ripgrep
    lsof
    appimage-run
    appimagekit
    openssl
    neofetch
    unclutter
    docker
    docker-compose
    postgresql
    yt-dlp
    ffmpeg
    pandoc
    glxinfo
    wine
    wine64
    winetricks

    # GUI
    spotify
    popcorntime
    vlc
    sioyek
    transmission-qt
    dbeaver
    discord
    piper
    android-studio
    obs-studio

    # Games
    tetrio-desktop
    bastet
    ttyper
    steam
    lutris

    # Utils
    dxvk
    libgccjit
    gcc
    glibc
    zlib
    clang
    gnumake
    usbutils
    gmp
    coreutils
    ncurses
    xclip
    wl-clipboard
    gtk3
    libratbag
    prisma-engines
    xorg.xev
    xorg.xmodmap
    xorg.setxkbmap
    xorg.xset
    texlive.combined.scheme-full

    # TypeScript
    nodejs

    # Python
    (python3.withPackages (ps: with ps; with python3Packages; [
      jupyter
      ipython

      pandas
      numpy
      matplotlib
      pyodbc
      sqlalchemy
      tabulate
      scikit-learn
      xgboost
    ]))

    # Haskell
    ghc
    stack
    cabal-install
    cabal2nix
    haskell-language-server

    # Rust
    rustup
    rustc
    rust-analyzer
    cargo

    # Scala
    scala
    scalafix
    scala-cli
    sbt
    metals
    coursier

    # Elm
    elmPackages.elm
    elmPackages.elm-language-server

    # Agda
    (agda.withPackages [ agdaPackages.standard-library ])
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  # Enables zsh.
  programs.zsh.enable = true;

  # Enables hyprland.
  programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      nvidiaPatches = true;
  };

  # Enables Noisetorch.
  programs.noisetorch.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # List services that you want to enable:
  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?
}
