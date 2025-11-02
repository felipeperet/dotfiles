{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # GUI
    # --------------------------------------------------------------------------
    spotify # A digital music service.
    # All-in-one cross-platform voice and text chat.
    (discord.override {
      withVencord = true;
    })
    slack # Desktop client for Slack.
    freetube # Open Source YouTube app for privacy.
    popcorntime # A BitTorrent client with a nice interface.
    transmission_4-qt # Fast, easy and free BitTorrent client.
    dbeaver-bin # Free multi-platform database tool.
    obs-studio # Open Broadcaster Software Studio.
    lxappearance-gtk2 # GTK theme switcher.
    zoom-us # Video conferencing application.
    nextcloud-client # Desktop sync client for Nextcloud.
    keepassxc # Offline password manager with many features.
    zotero # Collect, organize, cite, and share your research sources.
    libreoffice # Comprehensive, professional-quality productivity suite.
    ############################################################################
  ];
}
