pkgs:
let
  tmuxMenuSeperator = "|";
  cfg = {
    mainWorkspaceDir = "~/workspace";
    secondaryWorkspaceDir = "~/workspace2";
  };
in
{
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
    bind-key Tab display-menu -T "#[align=centre]Sessions" "Switch" . 'choose-session -Zw' Last l "switch-client -l" ${tmuxMenuSeperator} \
              "Open Main Workspace" m "display-popup -E \" td ${cfg.mainWorkspaceDir} \"" "Open Sec Workspace" s "display-popup -E \" td ${cfg.secondaryWorkspaceDir} \""   ${tmuxMenuSeperator} \
              "Kill Current Session" k "run-shell 'tmux switch-client -n \; tmux kill-session -t #{session_name}'"  "Kill Other Sessions" o "display-popup -E \"tkill \"" ${tmuxMenuSeperator} \
              Random r "run-shell 'tat random'" Emacs e "run-shell 'temacs'" ${tmuxMenuSeperator} \
              Exit q detach"
    '';
  };
}
