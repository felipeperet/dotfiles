{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # GUI
    # --------------------------------------------------------------------------
    spotify # A digital music service.
    popcorntime # A BitTorrent client with a nice interface.
    transmission_3-qt # A lightweight BitTorrent client - Qt GUI.
    dbeaver-bin # Free multi-platform database tool.
    vesktop # Alternate client for Discord with Vencord built-in.
    obs-studio # Open Broadcaster Software Studio.
    lxappearance-gtk2 # GTK theme switcher.
    zoom-us # Video conferencing application.
    keepass # GUI password manager with strong cryptography.
    ############################################################################
  ];
}
