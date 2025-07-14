{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Browsers
    # --------------------------------------------------------------------------
    librewolf # Fork of Firefox, focused on privacy, security and freedom.
    google-chrome # Google's web browser.
    tor-browser # Privacy-focused browser routing traffic.
    ############################################################################
  ];
}
