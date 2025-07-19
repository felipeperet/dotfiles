{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Browsers
    # --------------------------------------------------------------------------
    librewolf # Fork of Firefox, focused on privacy, security and freedom.
    brave # Privacy-oriented browser for Desktop and Laptop computers.
    tor-browser # Privacy-focused browser routing traffic.
    ############################################################################
  ];
}
