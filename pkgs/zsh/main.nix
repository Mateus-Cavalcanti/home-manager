# Credits to notusknot for the zsh config
# https://github.com/notusknot/dotfiles-nix/blob/main/config/zsh/zsh.nix
{pkgs, config, ...}:
{
  programs.starship = {
    enable = false;
    enableBashIntegration = true;
    enableFishIntegration = false;
    enableZshIntegration = true;
  };
  programs.command-not-found.enable = true;
  programs.zsh = {
    enable = true;
    initExtra = ''
      # Variables
      export EDITOR="nvim"
      export TERMINAL="alacritty"
      export BROWSER="firefox"
      export NIXOS_CONFIG_DIR="$HOME/.config/nixpkgs/"
      # I honestly don't know what this does
      # autoload -U colors && colors
      # eval "$(dircolors -b)"
      setopt histignorealldups sharehistory
      # Enable completion
      autoload -Uz compinit
      zstyle ":completion:*" menu select
      zstyle ":completion:*" list-colors ""
      zmodload zsh/complist
      # compinit -d $HOME/.cache/zcompdump
      # _comp_options+=(globdots)
      # Set vi-mode and bind ctrl + f to accept autosuggestions
      bindkey '^f' autosuggest-accept
      bindkey -v
      export PATH="$HOME/.local/usr/bin:$PATH"
      export PATH="$HOME/.local/venv/bin:$PATH"
      export PATH="$HOME/.local/usr/node/bin:$PATH"
      export PATH="$HOME/.cargo/bin:$PATH"
      # eval "$(oh-my-posh init zsh --config ~/.poshthemes/zash.omp.json)"
      VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
      VI_MODE_SET_CURSOR=true
      MODE_INDICATOR="%F{white}+%f"
      INSERT_MODE_INDICATOR="%F{yellow}+%f"
      export HISTCONTROL=ignoredups
      setopt autocd
      autoload znt-history-widget
      zle -N znt-history-widget
      bindkey "^R" znt-history-widget

      # zle-line-init() { zle -K vicmd; }
      # zle -N zle-line-init

      '' + builtins.readFile ./others.zsh;
      # Tweak settings for history
      history = {
          save = 100000;
          size = 100000;
          path = "$HOME/.cache/zsh_history";
      };

      # oh-my-zsh.enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["colored-man-pages" "command-not-found" "common-aliases" "zsh-interactive-cd" "zsh-navigation-tools" "react-native" "pip" "node" "git" "gh" "github" "vi-mode" "python" "man" "fzf" "thefuck"];
        theme="mh";
      };

      # Set some aliases
      shellAliases = {
          v = "nvim";
          c = "clear";
          unziptar = "tar -xvzf";
          mkdir = "mkdir -vp";
          rm = "rm -rifv";
          mv = "mv -iv";
          cp = "cp -riv";
          cat = "bat --paging=never --style=plain";
          fzf = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'";
          ls = "exa -a --icons";
          # ls="ls --hyperlink=auto --color=auto";
          tree = "exa --tree --icons";
          zshrc = "nvim $NIXOS_CONDIF_DIR/config/zsh/zsh.nix";
          home = "nvim $NIXOS_CONFIG_DIR/home.nix";
          config = "nvim $NIXOS_CONFIG_DIR/configuration.nix";
          nvimconf = "nvim $NIXOS_CONFIG_DIR/config/nvim/main.nix";
          fvf = "vim \"$(fzf)\"";
          nd = "nix develop -c $SHELL";
          editPackages = "nvim $HOME/.config/nixpkgs/pkgs/packages.nix";
          png = "kitty +kitten icat";
	  vim = "nvim";
      };

    #   # Source all plugins, nix-style
      plugins = [
      {
          name = "openai-zsh";
          src = pkgs.fetchFromGitHub {
              owner = "tom-doerr";
              repo = "zsh_codex";
              rev = "eceb9a1561679dded205bde95020f863f4e9b662";
              sha256 = "WLCVfUpTwPUoBmD7ZfEkUBW3B8F5JUN/PqnaUhWoZco=";
          };
      }
      {
          name = "fast-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
              owner = "zdharma";
              repo = "fast-syntax-highlighting";
              rev = "817916dfa907d179f0d46d8de355e883cf67bd97";
              sha256 = "0m102makrfz1ibxq8rx77nngjyhdqrm8hsrr9342zzhq1nf4wxxc";
          };
      }
      {
          name = "auto-ls";
          src = pkgs.fetchFromGitHub {
              owner = "desyncr";
              repo = "auto-ls";
              rev = "88704f2717fb176b91cdd4b7dbab05242bd02ddf";
              sha256 = "0z2qkd4g3k44wr28hydklgdnvp155g3kvxwr4xplxbbpyn21drqv";
              fetchSubmodules = true;
          };
      }
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
              owner = "zsh-users";
              repo = "zsh-autosuggestions";
              rev = "a411ef3e0992d4839f0732ebeb9823024afaaaa8";
              sha256 = "1g3pij5qn2j7v7jjac2a63lxd97mcsgw6xq6k5p7835q9fjiid98";
          };
      }
    #   {
    #     name = "zsh-nix-shell";
    #     file = "nix-shell.plugin.zsh";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "chisui";
    #       repo = "zsh-nix-shell";
    #       rev = "v0.5.0";
    #       sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
    #     };
    #   }
    ];
  };
}
