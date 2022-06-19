# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.grub.devices = [ "nodev" ];
  # boot.supportedFilesystems = [ "ntfs" ];
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.useOSProber = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "nixos"; # Define your hostname.
  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  hardware.opengl.driSupport = true;
  # For 32 bit applications
  hardware.opengl.driSupport32Bit = true;
  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";
  time.timeZone = "America/Sao_Paulo";
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "mateusc" ];
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Enable the X11 windowing system.
  #services.xserver.enable = true;
  services.dbus.packages = with pkgs; [ dconf gcr ];
  programs.dconf.enable = true;
  services.xserver = {
    enable = true;

    displayManager = {
      #lightdm.enable = true;
      lightdm = {
        enable = true;
        #greeters.enso.enable = true;
      };
      #sddm = {
      #  enable = true;
      #};
      defaultSession = "none+awesome";
    };
    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        lgi
      ];
    };
  };

  # Enable the Plasma 5 Desktop Environment.
  #services.xserver.displayManager.sddm.enable = true;
  #services.xserver.desktopManager.plasma5.enable = true;
  
  
  

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  services.xserver.layout = "br,us";
  services.xserver.xkbOptions = "grp:alt_space_toggle";
  # Enable CUPS to print documents.
  # services.printing.enable = true;
  networking.wireless.networks = {
    "Fransico_Oi_2G" = {                # SSID with no spaces or special characters
      pskRaw = "15e6573fdc104208397a401f15ae5c1538dc60eb6f5f2354cd0af02567140eef";
    };
    "_CAVAL_5G" = {         # SSID with spaces and/or special characters
      pskRaw = "0a028008ea553903828093506afee894d9871e4682c9d351369dca88a34a33f0";
    };
    "2.4GHZ NET VIRTUA AP202" = {                # Hidden SSID
      pskRaw = "5fafe56190476ce4eac796db09e4da84fe836e80962b9b41d9e7e9ebe200104b";
    };
  };
  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip pkgs.hplipWithPlugin ];
    defaultShared = true;
    browsing = true;
    extraConf = ''
    ServerAlias *
    '';
  };


  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-runtime"
    "hplip"
  ];

  services.searx = {
    enable = true;
    settings = {
      server.port = 8080;
      server.bind_address = "192.168.0.109";
      server.secret_key = "19e623b13cff5f48abc67637";
      outgoing = {
        request_timeout = 2.0;
	pool_connections = 100;
	pool_maxsize = 10;
	enable_http2 = true;
	retry_on_http_error = true;
      };
      #engines = lib.singleton
        #{ 
	#name = "bing";
        #engine = "bing";
	#shortcut = "bi";
	#base_url = "https://{language}.wikipedia.org/";
	#categories = "general";
	#timeout = 3.0;
	#api_key = "apikey";
	#disabled = false;
	#language = "en_US";
	#};
    };
  };
  programs.steam.enable = true;
  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

  programs.adb.enable = true;
  virtualisation.libvirtd.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mateusc = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "docker" "adbusers" ]; # Enable ‘sudo’ for the user.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.jane = {
  #   isNormalUser = true;
  #   extraGroups = [ "libvirtd" "wheel" ]; # Enable ‘sudo’ for the user.
  # };

  # Enable doas instead of sudo
  security.doas.enable = true;
  security.sudo.enable = false;

  # Configure doas
  
  security.doas.extraRules = [{
	users = [ "mateusc" ];
	keepEnv = true;
  }];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  #   firefox
  # ];
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    xorg.xbacklight
    testdisk
    kitty
    neovim
    alacritty # a decent terminal
    libusb-compat-0_1
    libusb1
    libusb
    virt-manager
  ];
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
  boot.extraModprobeConfig = '' options bluetooth disable_ertm=1 '';

  services.samba = {
    enable = true;
  };


  services.cron = {
    enable = true;
    systemCronJobs = [
      "* * * * *	mateusc	~/.config/nixpkgs/bash/internet.sh ~/var/log/net/connected.log"
      "* * * * *	mateusc	sleep 30; ~/.config/nixpkgs/bash/internet.sh ~/var/log/net/connected.log"
      "@reboot		mateusc	cat /etc/nixos/configuration.nix > ~/.config/nixpkgs/others/configuration.nix"
      "@hourly		mateusc	notify-send Drink water"
      "*/30 * * * *	root	updatedb"
    ];
  };
  services.openssh.enable = true;
  system.copySystemConfiguration = true;
  # List services that you want to enable:

  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_zen;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}

