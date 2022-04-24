{pkgs, fetchzip, ...}:

let
  color = import ./colors.nix;
in {
  programs.kitty = {
    enable = true;
    font= {
      name = "Fira Code";
      size = 6;
    };
    settings = {
      disable_ligatures = "never";
      disable_transparency = true;
      enable_audio_bell = true;
      scrollback_lines = 100000;
      cursor = "#a288f7";
      cursor_text_color = "#8d35c9";
      cursor_shape = "beam";
      focus_follows_mouse = false;
      remember_window_size = true;
      shell_integration = true;
      shell = "zsh";
      editor = "vim";
    };
    keybindings = {
      "ctrl-shift-z" = "scroll_to_prompt -1";
    };
    extraConfig = (builtins.readFile ./kitty.conf);
  };
}
