{pkgs, config, ...}:

let
  actualvolume = pkgs.writeShellScriptBin "actualvolume" ''
    pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
  '';
  foo = import (fetchTarball "https://github.com/mateus-cavalcanti/playground/archive/master.tar.gz") {};
  mail-password = pkgs.writeShellScriptBin "mail-password" ''
    cat /home/mateusc/Passwords/imap
  '';
  encrypte-sha256 = pkgs.writeShellScriptBin "encrypte-sha256" ''
  sha256sum $1 | awk '{ print $1 }'
  '';
  organize-files = pkgs.writeShellScriptBin "organize-files" ''
  bash -c "ls" | awk -v file=$1 '{ if (match($0, file)) { print $0 } }'| awk -F. '{ print $NF }' | uniq | xargs -I {} bash -c "mkdir -p {} && [ ! -f *.{} ] || mv *.{} {}"
  '';

  cpu-usage = pkgs.writeShellScriptBin "cpu-usage" ''
    echo $(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
  '';
  ram-usage = pkgs.writeShellScriptBin "ram-usage" ''
    echo $(free -m | awk 'NR==2{printf "%.0f\n", $3*100/$2 }')
  '';
  disk-usage = pkgs.writeShellScriptBin "disk-usage" ''
    echo $(df -h | awk '$NF=="/"{printf "%s\n", $5}')
  '';

  temperature = pkgs.writeShellScriptBin "temperature" ''
    sensors | grep "Core 0" | awk '{print $3}' | sed 's/[^0-9]*//g'
  '';
  actual-brightness = pkgs.writeShellScriptBin "actual-brightness" ''
    xrandr --verbose | awk '/Brightness/ { print $2; exit}'
  '';
  connected = pkgs.writeShellScriptBin "connectedc" ''
    connected=$(cat $HOME/var/log/net/connected.log | tail -1 | awk '{print $3}')
    if [ "$connected" == "true" ]; then
      echo "1"
    else
      echo "0"
    fi
  '';
  wtfetch = pkgs.writeShellScriptBin "wtfetch" (builtins.readFile ../bash/wtfetch.sh);
in
{

home.packages =  with pkgs; [

    libsForQt5.okular
    gnome.seahorse
    gnome.gedit
    gnome.nautilus
    gnome.gnome-boxes
    cached-nix-shell
    betterdiscordctl
    betterlockscreen
    texlive.combined.scheme-full
    latexrun
    rustup
    teams
    neofetch
    gcalcli
    docker-compose
    with-shell
    simplescreenrecorder
    mail-password
    encrypte-sha256
    organize-files
    python39
    multimarkdown
    unzip
    sc-im
    wtfetch
    fzf
    abiword
    ruby
    nuclear
    onlyoffice-bin
    krita
    gimp
    mail-password
    keepassxc
    foo
    font-manager
    # mariadb
    palenight-theme
    feh
    libwebp
    img2pdf
    discord
    xclip
    gcc
    gdrive
    libnotify
    bat
    bleachbit
    jq
    dmenu
    drawing
    tor-browser-bundle-bin
    gh
    fira-code
    losslesscut-bin
    nodejs
    php
    ripgrep
    xorg.xkill
    papirus-icon-theme
    lua
    pfetch
    exa
    python38Packages.pygments
    (nerdfonts.override { fonts = [ "Iosevka" "FiraCode"]; })
    poppler_utils
    mpv
    atool
    lynx
    fltk
    mediainfo
    ffmpegthumbnailer
    gnupg
    odt2txt
    google-chrome
    htop
    lm_sensors
    kdenlive
    cpu-usage
    ram-usage
    disk-usage
    temperature
    jdk
    clang-tools
    killall
    xdotool
    ngrok
    xclip
    grapejuice
    nix-prefetch-github
    actual-brightness
    connected
    lazygit
    gccStdenv
    inotify-tools
    thefuck
    weechat
    python39Packages.pip
    wine
    itch
    chuck
    lldb
    gdb
    cmake
    llvm
    ninja
    meson
    # libgccjit
    # gcc-unwrapped
    bintools-unwrapped


    # Neovim related somehow
    xcompmgr
    rnix-lsp
    sumneko-lua-language-server
    pyright
    texlab
    deno
    lolcat
    tridactyl-native
    rust-analyzer
    actualvolume
    gnome.gnome-clocks
    nodePackages.bash-language-server
    rnix-lsp
  ];
}
