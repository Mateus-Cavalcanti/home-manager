{pkgs, config, ...}:

let
  username = "mateusc";
  gtkFilePrefix = "file:///home/${username}/";
in
{
  gtk = {
    enable = true;
    font = {
      name = "Fira Code";
      size = 8;
    };
    theme.name = "palenight";
    gtk3 = {
      bookmarks = [
        "${gtkFilePrefix}/Downloads"
        "${gtkFilePrefix}/Documents"
        "${gtkFilePrefix}/Projects"
        "${gtkFilePrefix}/.config"
      ];
    };
    iconTheme.name = "Papirus-Dark";
  };
}
