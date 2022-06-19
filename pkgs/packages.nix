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
    gnome.nautilus
    cached-nix-shell
    betterdiscordctl
    betterlockscreen
    texlive.combined.scheme-full
    latexrun
    teams
    neofetch
    simplescreenrecorder
    mail-password
    encrypte-sha256
    organize-files
    python39
    unzip
    sc-im
    wtfetch
    fzf
    abiword
    font-manager
    # mariadb
    palenight-theme
    feh
    libwebp
    img2pdf
    discord
    xclip
    /* gcc */
    gdrive
    libnotify
    bat
    bleachbit
    dmenu
    tor-browser-bundle-bin
    gh
    fira-code
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
    fltk
    mediainfo
    ffmpegthumbnailer
    gnupg
    odt2txt
    google-chrome
    htop
    lm_sensors
    cpu-usage
    ram-usage
    disk-usage
    temperature
    jdk
    clang-tools
    killall
    xdotool
    xclip
    nix-prefetch-github
    actual-brightness
    connected
    gccStdenv
    inotify-tools
    thefuck
    python39Packages.pip
    wine64
    chuck
    lldb
    gdb
    cmake
    llvm
    ninja
    meson
    # libgccjit
    # gcc-unwrapped
    # bintools-unwrapped
    xcompmgr
    lfs
    luajitPackages.luarocks
    usbutils
    libusbgx
    gusb
    libusb1
    libusb1
    tdesktop
    heroku
    php81Packages.composer
    jq
    conan
    nlohmann_json
    grapejuice
    rustup

    # Neovim related somehow
    neovide
    actualvolume
  ];
}
