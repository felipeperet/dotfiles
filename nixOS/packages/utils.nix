{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Utils
    # --------------------------------------------------------------------------
    dxvk # Vulkan-based translation layer for Direct3D.
    usbutils # Linux USB utilities.
    coreutils # File, shell and text manipulation utilities.
    libffi # A foreign function call interface library.
    xclip # Command line interface to the X11 clipboard.
    gtk3 # Toolkit for creating graphical UIs.
    prisma-engines # Engines behind Prisma (database toolkit).
    zlib # Library for compression.
    libsodium # Library for encryption.
    ncurses # Library for writing text-based UIs.
    gmp # Library for arbitrary precision arithmetic.
    openssl # Cryptographic library that implements the SSL and TLS protocols.
    ############################################################################
  ];
}
