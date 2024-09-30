{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    ############################################################################
    # Editors
    # --------------------------------------------------------------------------
    vim # A highly configurable text editor.
    neovim # Vim-fork focused on extensibility and usability.
    neovide # A simple graphical user interface for Neovim.
    vscode # Visual Studio Code.
    emacs # An extensible, customizable text editor.
    emacsPackages.engrave-faces
    emacsPackages.ox-reveal
    ############################################################################
  ];
}
