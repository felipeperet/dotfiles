{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Games
    # --------------------------------------------------------------------------
    gamemode # Optimise Linux system performance on demand.
    ttyper # A terminal typing game.
    dsda-doom # An Doom source port with a focus on speedrunning.
    gzdoom # Modder-friendly source port based on the DOOM engine.
    space-cadet-pinball # Reverse engineering of 3D Pinball for Windows.
    ############################################################################
  ];
}
