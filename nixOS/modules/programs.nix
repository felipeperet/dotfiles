{pkgs, ...}: {
  programs = {
    # Enable zsh.
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      ohMyZsh = {
        enable = true;
      };
      syntaxHighlighting.enable = true;
    };

    # Enable hyprland.
    hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    # Enable Steam.
    steam = {
      enable = true;
      # Open ports in the firewall for Steam Remote Play
      remotePlay.openFirewall = true;
      # Open ports in the firewall for Source Dedicated Server
      dedicatedServer.openFirewall = true;
    };

    # Enable Noisetorch.
    noisetorch.enable = true;

    # Enable unpatched dynamic binaries.
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [
      openssl_1_1 # A library that implements the SSL and TLS protocols.
    ];
  };
}
