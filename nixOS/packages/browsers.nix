{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Browsers
    # --------------------------------------------------------------------------
    firefox # A popular web browser.
    google-chrome # Google's web browser.
    tor-browser # Privacy-focused browser routing traffic.
    ############################################################################
  ];
}
