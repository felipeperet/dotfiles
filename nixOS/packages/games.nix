{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Games
    # --------------------------------------------------------------------------
    ttyper # A terminal typing game.
    space-cadet-pinball # Reverse engineering of 3D Pinball for Windows.
    lutris # Open Source gaming platform for GNU/Linux.
    ############################################################################
  ];
}
