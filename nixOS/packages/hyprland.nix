{pkgs, ...}: let
  # Define the overridden waybar package.
  customWaybar = pkgs.waybar.overrideAttrs (oldAttrs: {
    mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
  });
in {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Wayland + Hyprland
    # --------------------------------------------------------------------------
    libnotify # Library for sending desktop notifications.
    swww # Efficient animated wallpaper daemon for wayland.
    wlogout # Wayland based logout menu.
    networkmanagerapplet # Applet for managing network connections.
    grim # A tool to capture screenshots in Wayland.
    slurp # Select a region in Wayland.
    light # GNU/Linux application to control backlights.
    wl-clipboard # Wayland clipboard utilities.
    swayimg # Wayland image viewer.
    zathura # A lightweight document viewer.
    mpv # A media player.
    ############################################################################
  ];
}
