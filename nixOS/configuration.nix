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
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      substituters = [
        "https://cache.iog.io"
        "https://cache.zw3rk.com"
        "https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
        "loony-tools:pr9m4BkM/5/eSTZlkQyRt57Jz7OMBxNSUiMC4FkcNfk="
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
  hardware.opengl.enable = true;
  # hardware.nvidia.optimus_prime.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;

  # Configure xserver.
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia" "intel"];
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

  # Enabling libinput.
  services.xserver.libinput.enable = true;

  # Enable PostgreSQL.
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sasdelli = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Felipe Sasdelli";
    extraGroups = ["networkmanager" "wheel" "input" "docker" "audio"];
    packages = with pkgs; [firefox neovim];
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
    neovim # Vim-fork focused on extensibility and usability.
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
    cinnamon.nemo # The Nemo file manager from the Cinnamon desktop.
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
    zoxide # A fast cd command that learns your habits.
    cloc # A program that counts lines of source code.
    tldr # Simplified and community-driven man pages.
    wget # A tool to retrieve files using HTTP, HTTPS, FTP, and FTPS.
    curl # A tool and library for transferring data with URL syntax.
    git # A distributed version control system.
    htop # An interactive process viewer.
    duf # A disk usage utility.
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
    openssl # A toolkit for TLS and SSL protocols.
    neofetch # A command-line system information tool.
    docker # A platform to develop, ship, and run applications.
    docker-compose # Tool for defining and running Docker applications.
    postgresql # A powerful, open source object-relational database system.
    yt-dlp # A youtube-dl fork with various improvements.
    imagemagick # A tool to create, edit, and compose bitmap images.
    ffmpeg # A solution to record, convert, and stream audio and video.
    pandoc # A universal document converter.
    libinput # A tool for for handling input devices
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
    transmission-qt # A lightweight BitTorrent client - Qt GUI.
    telegram-desktop # Telegram Desktop messaging app.
    dbeaver # Free multi-platform database tool.
    discord # Voice and text chat for gamers.
    android-studio # The official Android IDE.
    obs-studio # Open Broadcaster Software Studio.
    lxappearance-gtk2 # GTK theme switcher.
    libreoffice # Comprehensive variant of openoffice.org.
    zoom-us # Video conferencing application.
    ############################################################################

    ############################################################################
    # Games
    # --------------------------------------------------------------------------
    ttyper # A terminal typing game.
    tetrio-desktop # Desktop version of TETR.IO, an online Tetris game.
    bastet # Bastard Tetris - an evil Tetris clone.
    crispy-doom # A Doom source port.
    lutris # Open Source gaming platform for GNU/Linux.
    ############################################################################

    ############################################################################
    # Utils
    # --------------------------------------------------------------------------
    dxvk # Vulkan-based translation layer for Direct3D
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
        haskell-language-server # Haskell Language Server Protocol.
      ]))
    ############################################################################

    ############################################################################
    # OCaml
    # --------------------------------------------------------------------------
    ocaml # A functional and statically typed programming language.
    opam # A package manager for OCaml.
    dune_3 # A composable build system.
    ocamlformat # Auto-formatter for OCaml code.
    ocamlPackages.utop # Universal toplevel for OCaml.
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
    typescript # A superset of JavaScript that compiles to clean JavaScript.
    prettierd # Prettier, as a daemon, for improved formatting speed.
    ############################################################################

    ############################################################################
    # Python
    # --------------------------------------------------------------------------
    (python3.withPackages (ps:
      with ps;
      with python3Packages; [
        jupyter
        ipython
        pandas
        numpy
        matplotlib
        scikit-image
        pyodbc
        sqlalchemy
        tabulate
        scikit-learn
        xgboost
      ]))
    ############################################################################

    ############################################################################
    # Agda
    # --------------------------------------------------------------------------
    (agda.withPackages [agdaPackages.standard-library]) # A proof assistant.
    ############################################################################

    ############################################################################
    # TOML
    # --------------------------------------------------------------------------
    taplo # A TOML toolkit written in Rust.
    ############################################################################
  ];

  fonts.packages = with pkgs; [
    font-awesome
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
    enableNvidiaPatches = true;
  };

  # Enables Noisetorch.
  programs.noisetorch.enable = true;

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
