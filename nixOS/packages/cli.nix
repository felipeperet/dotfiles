{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # CLI
    # --------------------------------------------------------------------------
    fastfetch # Like neofetch, but much faster because written in C.
    zoxide # A fast cd command that learns your habits.
    tldr # Simplified and community-driven man pages.
    wget # A tool to retrieve files using HTTP, HTTPS, FTP, and FTPS.
    curl # A tool and library for transferring data with URL syntax.
    kubo # IPFS implementation in Go.
    zip # A compression utility.
    unzip # A decompression utility.
    rar # Utility for RAR archives.
    unrar # Utility for RAR archives.
    parted # Create, destroy, resize, check, and copy partitions.
    cryptsetup # LUKS for dm-crypt.
    git # A distributed version control system.
    git-filter-repo # Quickly rewrite git repository history.
    act # Run your GitHub Actions locally.
    lazygit # Simple terminal UI for git commands.
    gnupg # A GPL OpenPGP implementation.
    tokei # Program that allows you to count your code, quickly.
    ncdu # Disk usage analyzer with an ncurses interface.
    btop # Monitor of resources.
    lm_sensors # Tools for reading hardware sensors.
    dmidecode # Tool that reads information about your system's hardware.
    radeontop # Top-like tool for viewing AMD Radeon GPU utilization.
    cpu-x # Gathers information on CPU, motherboard and more.
    sysbench # Modular, cross-platform and multi-threaded benchmark tool.
    stress-ng # Stress test a computer system.
    glxinfo # Display information about the GLX implementation.
    trash-cli # Command line interface to the freedesktop.org trashcan.
    gdown # A CLI tool for downloading large files from Google Drive.
    killall # A tool to kill all instances of a process.
    direnv # An environment switcher for the shell.
    tree # A recursive directory listing command.
    ripgrep # A line-oriented search tool.
    lsof # Lists open files.
    pkg-config # Tool to compile and link library flags.
    appimage-run # A tool to run AppImages.
    docker # A platform to develop, ship, and run applications.
    docker-compose # Tool for defining and running Docker applications.
    postgresql # A powerful, open source object-relational database system.
    yt-dlp # A youtube-dl fork with various improvements.
    imagemagick # A tool to create, edit, and compose bitmap images.
    ffmpeg # A solution to record, convert, and stream audio and video.
    libinput # A tool for for handling input devices.
    evtest # A tool for testing input device.
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
  ];
}
