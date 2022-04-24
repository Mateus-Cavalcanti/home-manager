{ configs, pkgs, ... }:

{
  # The home username
  home.username = "mateusc";

  # The home directory
  home.homeDirectory = "/home/mateusc";

  # The home version
  home.stateVersion = "22.05";

  # Allow it install and manage itself
  programs.home-manager.enable = true;

  # Importing the imports manager
  imports = [ ./manager.nix ];
}
