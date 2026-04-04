{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Editors
    # --------------------------------------------------------------------------
    vim # A highly configurable text editor.
    # Vim-fork focused on extensibility and usability.
    (neovim.override {
      withPython3 = true;
    })
    neovide # A simple graphical user interface for Neovim.
    obsidian # Powerful knowledge base.
    vscode # Open source source code editor developed by Microsoft.
    quarto # Open-source publishing system built on Pandoc.
    pandoc # Conversion between documentation formats.
    emacs # An extensible, customizable text editor.
    emacsPackages.engrave-faces
    emacsPackages.ox-reveal
    texlive.combined.scheme-full # Comprehensive TeX system.
    ############################################################################
  ];
}
