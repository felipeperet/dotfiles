# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  # Define the overridden waybar package.
  customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
  });
in {
  system.stateVersion = "24.05";
  home-manager.users.sasdelli.home.stateVersion = "24.05";

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./home.nix
  ];

  # Stylix Configuration
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = /home/sasdelli/Wallpapers/nixOS-wallpaper.png;

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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Define your hostname.
  networking.hostName = "nixos";

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

  # Enabling Graphics Cards
  hardware.graphics.enable = true;

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    modesetting.enable = true;
    # open = true; # Set to true for open-source drivers or false for closed-source drivers.
    open = false; # Use closed-source drivers
  };

  # Configure xserver.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia" "intel"];
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };
    xkb.layout = "br";
    xkb.variant = "";
  };

  # Configure console keymap.
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable Bluetooth.
  hardware.bluetooth.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = false;
  };

  # Enabling libinput.
  services.libinput.enable = true;

  # Enable PostgreSQL.
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
  };

  # Enable Flatpak.
  services.flatpak.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sasdelli = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Felipe Sasdelli";
    extraGroups = ["networkmanager" "wheel" "input" "docker" "audio"];
    packages = with pkgs; [firefox];
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Permitted Insecure Packages
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  # Enable Steam
  programs.steam = {
    enable = true;
    # Open ports in the firewall for Steam Remote Play
    remotePlay.openFirewall = true;
    # Open ports in the firewall for Source Dedicated Server
    dedicatedServer.openFirewall = true;
  };

  environment.variables.GDK_BACKEND = "wayland";

  environment.sessionVariables = {
    # If your cursor becomes invisible
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Terminal
    # --------------------------------------------------------------------------
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator.
    ############################################################################

    ############################################################################
    # Editors
    # --------------------------------------------------------------------------
    vim # A highly configurable text editor.
    # neovim # Vim-fork focused on extensibility and usability.
    neovide # A simple graphical user interface for Neovim.
    vscode # Visual Studio Code.
    emacs # An extensible, customizable text editor.
    emacsPackages.engrave-faces
    emacsPackages.ox-reveal
    ############################################################################

    ############################################################################
    # Browsers
    # --------------------------------------------------------------------------
    firefox # A popular web browser.
    google-chrome # Google's web browser.
    tor-browser # Privacy-focused browser routing traffic.
    ############################################################################

    ############################################################################
    # Wayland + Hyprland
    # --------------------------------------------------------------------------
    customWaybar # A customizable wayland bar.
    dunst # A lightweight notification daemon.
    libnotify # Library for sending desktop notifications.
    rofi-wayland # An application launcher, works with Wayland.
    swww # Uncertain without more context.
    networkmanagerapplet # Applet for managing network connections.
    blueberry # Bluetooth configuration tool.
    grim # A tool to capture screenshots in Wayland.
    slurp # Select a region in Wayland.
    light # GNU/Linux application to control backlights.
    wl-clipboard # Wayland clipboard utilities.
    swayimg # Wayland image viewer.
    zathura # A lightweight document viewer.
    mpv # A media player.
    nemo # The Nemo file manager from the Cinnamon desktop.
    ############################################################################

    ############################################################################
    # Media / Audio
    # --------------------------------------------------------------------------
    pulseaudioFull # A sound system for POSIX OSes.
    pulsemixer # CLI and curses mixer for PulseAudio.
    playerctl # MPRIS command-line controller for media players.
    mpd # Music Player Daemon.
    ############################################################################

    ############################################################################
    # CLI
    # --------------------------------------------------------------------------
    home-manager
    neofetch # A command-line system information tool.
    # yazi # Blazing fast terminal file manager written in Rust.
    zoxide # A fast cd command that learns your habits.
    tldr # Simplified and community-driven man pages.
    wget # A tool to retrieve files using HTTP, HTTPS, FTP, and FTPS.
    curl # A tool and library for transferring data with URL syntax.
    git # A distributed version control system.
    git-filter-repo # Quickly rewrite git repository history.
    lazygit # Simple terminal UI for git commands.
    loc # Count lines of code quickly.
    ncdu # Disk usage analyzer with an ncurses interface.
    duf # A disk usage utility.
    htop # An interactive process viewer.
    trash-cli # Command line interface to the freedesktop.org trashcan.
    gdown # A CLI tool for downloading large files from Google Drive.
    zip # A compression utility.
    unzip # A decompression utility.
    rar # Utility for RAR archives.
    unrar # Utility for RAR archives.
    killall # A tool to kill all instances of a process.
    direnv # An environment switcher for the shell.
    tree # A recursive directory listing command.
    ripgrep # A line-oriented search tool.
    lsof # Lists open files.
    pkg-config # Tool to compile and link library flags.
    appimage-run # A tool to run AppImages.
    appimagekit # Tools for working with AppImages.
    docker # A platform to develop, ship, and run applications.
    docker-compose # Tool for defining and running Docker applications.
    postgresql # A powerful, open source object-relational database system.
    yt-dlp # A youtube-dl fork with various improvements.
    imagemagick # A tool to create, edit, and compose bitmap images.
    ffmpeg # A solution to record, convert, and stream audio and video.
    pandoc # A universal document converter.
    libinput # A tool for for handling input devices.
    evtest # A tool for testing input device.
    glxinfo # Display information about the GLX implementation.
    wine # Software for running Windows applications on Linux.
    wine64 # 64-bit version of Wine.
    winetricks # Script to help install various Windows software on Wine.
    cmatrix # Console-based Matrix-style animation.
    xdotool # Command-line X11 automation tool.
    xbindkeys # Binds keys to shell commands.
    xorg.xev # Print contents of X events.
    xorg.xmodmap # Modify keymaps.
    xorg.setxkbmap # Set keyboard keymaps.
    xorg.xset # User preference utility for X.
    texlive.combined.scheme-full # Comprehensive TeX system.
    ############################################################################

    ############################################################################
    # GUI
    # --------------------------------------------------------------------------
    spotify # A digital music service.
    popcorntime # A BitTorrent client with a nice interface.
    transmission_3-qt # A lightweight BitTorrent client - Qt GUI.
    dbeaver-bin # Free multi-platform database tool.
    discord # Voice and text chat for gamers.
    obs-studio # Open Broadcaster Software Studio.
    lxappearance-gtk2 # GTK theme switcher.
    zoom-us # Video conferencing application.
    keepass # GUI password manager with strong cryptography.
    ############################################################################

    ############################################################################
    # Games
    # --------------------------------------------------------------------------
    ttyper # A terminal typing game.
    dsda-doom # An Doom source port with a focus on speedrunning.
    gzdoom # Modder-friendly source port based on the DOOM engine.
    ############################################################################

    ############################################################################
    # Utils
    # --------------------------------------------------------------------------
    dxvk # Vulkan-based translation layer for Direct3D.
    usbutils # Linux USB utilities.
    coreutils # File, shell and text manipulation utilities.
    libffi # A foreign function call interface library.
    xclip # Command line interface to the X11 clipboard.
    gtk3 # Toolkit for creating graphical UIs.
    prisma-engines # Engines behind Prisma (database toolkit).
    zlib # Library for compression.
    libsodium # Library for encryption.
    ncurses # Library for writing text-based UIs.
    gmp # Library for arbitrary precision arithmetic.
    ############################################################################

    ############################################################################
    # Nix
    # --------------------------------------------------------------------------
    alejandra # The Uncompromising Nix Code Formatter.
    ############################################################################

    ############################################################################
    # Lua
    # --------------------------------------------------------------------------
    lua # A lightweight and embeddable scripting language.
    lua-language-server # Language server for Lua.
    stylua # An opinionated Lua code formatter.
    ############################################################################

    ############################################################################
    # Rust
    # --------------------------------------------------------------------------
    rustc # A safe, concurrent, practical language.
    cargo # A tool for downloading project's dependencies and building.
    rustfmt # A tool for formatting Rust code according to style guidelines.
    rust-analyzer # A modular compiler frontend for the Rust language.
    ############################################################################

    ############################################################################
    # Haskell
    # --------------------------------------------------------------------------
    (ghc.withPackages (ps:
      with ps; [
        cabal-install # A tool to compile and install Haskell libraries.
        cabal2nix # Convert a Cabal file into a Nix build expression.
        stack # A build tool for Haskell.
        fourmolu # A formatter for Haskell source code.
        # haskell-language-server # Haskell Language Server Protocol.
      ]))
    ############################################################################

    ############################################################################
    # OCaml
    # --------------------------------------------------------------------------
    ocaml # A functional and statically typed programming language.
    opam # A package manager for OCaml.
    dune_3 # A composable build system.
    ocamlformat # Auto-formatter for OCaml code.
    ocamlPackages.ocaml-lsp # OCaml Language Server Protocol.
    ############################################################################

    ############################################################################
    # C / C++
    # --------------------------------------------------------------------------
    gcc # GNU Compiler Collection.
    glibc # GNU C Library.
    gnumake # GNU make utility.
    clang # C, C++, and Objective-C compiler.
    cmake # A tool to manage the build process of software.
    libgccjit # Just-In-Time compilation support in GCC.
    clang-tools # Standalone command line tools for C development.
    ############################################################################

    ############################################################################
    # JavaScript / TypeScript
    # --------------------------------------------------------------------------
    nodejs # JavaScript runtime built on Chrome's V8 JavaScript engine.
    nodePackages.ts-node # TypeScript execution environment and REPL for nodejs.
    deno # A secure runtime for JavaScript and TypeScript.
    typescript # A superset of JavaScript that compiles to clean JavaScript.
    prettierd # Prettier, as a daemon, for improved formatting speed.
    ############################################################################

    ############################################################################
    # Python
    # --------------------------------------------------------------------------
    (python3.withPackages (ps:
      with ps;
      with python3Packages; [
        pip
        jupyter
        ipython
        pandas
        numpy
        matplotlib
        scikit-learn
        scikit-image
        pyodbc
        sqlalchemy
        tabulate
        xgboost
        torch
        torchvision
        gdown
      ]))
    ############################################################################

    ############################################################################
    # Agda
    # --------------------------------------------------------------------------
    (agda.withPackages [agdaPackages.standard-library]) # A proof assistant.
    ############################################################################

    ############################################################################
    # Lean4
    # --------------------------------------------------------------------------
    # lean4
    elan
    ############################################################################

    ############################################################################
    # TOML
    # --------------------------------------------------------------------------
    taplo # A TOML toolkit written in Rust.
    ############################################################################
  ];

  fonts.packages = with pkgs; [
    nerdfonts
    monaspace
  ];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Enables zsh.
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    ohMyZsh = {
      enable = true;
    };
    syntaxHighlighting.enable = true;
  };

  # Enables hyprland.
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enables Noisetorch.
  programs.noisetorch.enable = true;

  # Enables unpatched dynamic binaries.
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    openssl_1_1 # A library that implements the SSL and TLS protocols.
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # List services that you want to enable:
  virtualisation.docker.enable = true;
}
