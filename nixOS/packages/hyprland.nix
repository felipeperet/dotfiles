{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
    nemo-python # Python bindings for the Nemo extension library.
    ############################################################################
  ];
}
