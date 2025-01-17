{pkgs, ...}: {
  services = {
    # Configure xserver.
    xserver = {
      enable = true;
      videoDrivers = ["nvidia" "modesetting"];
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      xkb.layout = "br";
      xkb.variant = "";
    };

    # Enable Thunar extra functionalities.
    gvfs.enable = true; # Mount, trash, and other functionalities.
    tumbler.enable = true; # Thumbnail support for images.

    # Enable smart card support for GPG.
    pcscd.enable = true;

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    # Enable Blueman for Bluetooh.
    blueman.enable = true;

    # Enable libinput.
    libinput.enable = true;

    # Enable PostgreSQL.
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
    };

    # Enable Flatpak.
    flatpak.enable = true;

    # Disable Pulseaudio (using PipeWire instead).
    pulseaudio.enable = false;
  };
}
