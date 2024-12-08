{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # CLI
    # --------------------------------------------------------------------------
    fastfetch # Like neofetch, but much faster because written in C.
    yazi # Blazing fast terminal file manager written in Rust.
    zoxide # A fast cd command that learns your habits.
    tldr # Simplified and community-driven man pages.
    wget # A tool to retrieve files using HTTP, HTTPS, FTP, and FTPS.
    curl # A tool and library for transferring data with URL syntax.
    git # A distributed version control system.
    git-credential-manager # Secure Git credential storage with authentication.
    git-filter-repo # Quickly rewrite git repository history.
    act # Run your GitHub Actions locally.
    lazygit # Simple terminal UI for git commands.
    loc # Count lines of code quickly.
    ncdu # Disk usage analyzer with an ncurses interface.
    btop # Monitor of resources.
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
  ];
}
