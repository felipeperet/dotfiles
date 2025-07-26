{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Editors
    # --------------------------------------------------------------------------
    vim # A highly configurable text editor.
    neovim # Vim-fork focused on extensibility and usability.
    neovide # A simple graphical user interface for Neovim.
    quarto # Open-source publishing system built on Pandoc.
    pandoc # Conversion between documentation formats.
    emacs # An extensible, customizable text editor.
    emacsPackages.engrave-faces
    emacsPackages.ox-reveal
    texlive.combined.scheme-full # Comprehensive TeX system.
    ############################################################################
  ];
}
