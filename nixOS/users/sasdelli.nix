{pkgs, ...}: {
  # Main user account.
  users.users.sasdelli = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Felipe Sasdelli";
    extraGroups = ["networkmanager" "wheel" "input" "docker" "audio"];
    packages = with pkgs; [firefox];
  };
}
