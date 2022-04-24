{ pkgs, configs, lib, ... }:
{
  imports = [
    ./pkgs/startup.nix
    ./pkgs/nvim/main.nix
    ./pkgs/kitty/main.nix 
    ./pkgs/zathura/main.nix
    ./pkgs/firefox/main.nix
    ./pkgs/email/main.nix
    ./pkgs/zsh/main.nix
    ./pkgs/tmux/main.nix
    ./pkgs/lf/main.nix
    ./pkgs/emacs/main.nix
    ./pkgs/packages.nix
    ./pkgs/gtk/main.nix
  ];
    
  nixpkgs.config.allowUnfree = true;
  news.display = "notify";
  fonts.fontconfig.enable = true;
  manual = {
    html.enable = true;
    json.enable = true;
  };
  # services.picom.enable = true;

}
