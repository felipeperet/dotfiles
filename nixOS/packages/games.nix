{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Games
    # --------------------------------------------------------------------------
    ttyper # A terminal typing game.
    dsda-doom # An Doom source port with a focus on speedrunning.
    gzdoom # Modder-friendly source port based on the DOOM engine.
    pokemmo-installer # Installer and Launcher for the PokeMMO emulator.
    ############################################################################
  ];
}
