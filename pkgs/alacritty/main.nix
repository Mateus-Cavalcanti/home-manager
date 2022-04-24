pkgs:

let 
  color = import ./colors.nix;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = color.main;
      window.opacity = 1;
      font = {
        normal.family = "Iosevka Nerd Font";
        size = 7;
      };
      shell = "/nix/store/1wb43vynn5dqzk7acf202znladbc4722-home-manager-path/bin/zsh";
        normal.family = "Fira Code";
        size = 7;
      };
      shell = "zsh";
      dimensions = {
        columns = 100;
        lines = 75;
        padding = {
          y = 5;
        };
      };
    };
}
