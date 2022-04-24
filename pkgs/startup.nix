pkgs:

{
  programs = {
    git = {
      enable = true;
      ignores = ["*.ignore.*"];
      userName = "Mateus-Cavalcanti";
      userEmail = "mateusdccavalcanti@gmail.com";
      aliases = {
        prettylog =
          "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        root = "rev-parse --show-toplevel";
      };
    };
  };
  services = {
    # picom = {
    #   enable = true;
    # };
    flameshot.enable = true;
  };
}
