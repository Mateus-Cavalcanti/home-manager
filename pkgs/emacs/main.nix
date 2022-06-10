pkgs:

{
  programs.emacs = {
    enable = true;
  };
  services.emacs = {
    enable = true;
    client.enable = true;
    socketActivation.enable = true;
  };
}
