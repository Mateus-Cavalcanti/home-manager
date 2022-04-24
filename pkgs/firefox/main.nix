{pkgs, config, lib, ...}:

{
  # pkgs.firefox.override = {
  #   cfg = {
  #     enableTridactylNative = true;
  #   };
  # };
  programs.firefox = {
    enable = true;
    # package = pkgs.librewolf;
    # package = pkgs.firefox.override {
    #   cfg = {
    #     enableTridactylNative = true;
    #   };
    # };
  };
}
