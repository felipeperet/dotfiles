{pkgs, ...}: {
  services = {
    # Configure xserver.
    xserver = {
      enable = true;
      videoDrivers = ["nvidia" "intel"];
      displayManager.gdm = {
        enable = true;
        wayland = true;
      };
      xkb.layout = "br";
      xkb.variant = "";
    };

    # Enable sound with pipewire.
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = false;
    };

    # Enable libinput.
    libinput.enable = true;

    # Enable PostgreSQL.
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
    };

    # Enable Flatpak.
    flatpak.enable = true;
  };
}
