{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Media / Audio
    # --------------------------------------------------------------------------
    pulseaudioFull # A sound system for POSIX OSes.
    pulsemixer # CLI and curses mixer for PulseAudio.
    playerctl # MPRIS command-line controller for media players.
    mpd # Music Player Daemon.
    cava # Console-based Audio Visualizer for Alsa.
    ############################################################################
  ];
}
