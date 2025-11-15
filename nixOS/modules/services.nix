{pkgs, ...}: {
  services = {
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    # Configure xserver.
    xserver = {
      enable = true;
      videoDrivers = ["amdgpu"];
      xkb.layout = "br";
      xkb.variant = "";
    };

    # Enable Thunar extra functionalities.
    gvfs.enable = true; # Mount, trash, and other functionalities.
    tumbler.enable = true; # Thumbnail support for images.

    # Enable Gnome Keyring.
    gnome.gnome-keyring.enable = true;

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

    # Enable Sunshine for streaming.
    sunshine = {
      enable = true;
      openFirewall = true;
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

    # Enable OpenRGB.
    hardware.openrgb.enable = true;

    # Necessary for Rootless mode in DeepCool AK620 Digital monitoring.
    udev.extraRules = ''
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3633", MODE="0666"
    '';

    # Disable USB autosuspend for Bluetooth to improve signal strength.
    # udev.extraRules = ''
    #   SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3633", MODE="0666"
    #   ACTION=="add", SUBSYSTEM=="usb", DRIVERS=="btusb", ATTR{power/control}="on"
    # '';

    # Disable Pulseaudio (using PipeWire instead).
    pulseaudio.enable = false;
  };
}
