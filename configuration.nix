# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  catppuccin.flavor = "mocha";
  catppuccin.enable = true;

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/vda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

#    programs.uwsm.enable = true;
#    programs.uwsm.waylandCompositors.hyprland = {
#      prettyName = "Hyprland";
#      comment = "Hyprland compositor managed by UWSM";
#      binPath = "/run/current-system/sw/bin/Hyprland";
#    };


   # wayland.windowManager.hyprland = {
   # programs.hyprland.enable = true;
   # programs.hyprland.withUWSM = true;

   environment.sessionVariables.NIXOS_OZONE_WL = "1";
   environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";

    # Enable the X11 windowing system.
    services.xserver.enable = true;
  
    # Enable the GNOME Desktop Environment.

#        services.displayManager.sddm= {
#          enable = true;
#           # theme = "catppuccin-mocha";
#           package = pkgs.kdePackages.sddm;
#        };
    # pkgs.kdePackages.sddm.enable = true;
     
     programs.hyprland = {
     	enable = true;
	xwayland.enable = true;
     };
     services.xserver.displayManager.gdm = {
     	enable = true;
	wayland = true;
      };
     services.xserver.desktopManager.gnome.enable = true;
  
   # Configure keymap in X11
   services.xserver.xkb = {
     layout = "us";
     variant = "";
   };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ram = {
    isNormalUser = true;
    description = "Ram";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    	gparted
    	kitty
    	firefox
    	networkmanager_dmenu
    	librewolf
    	tmux
	mpv
	libqalculate
	fzf
	zoxide
	jq
	poppler
	libgcc
	btop
	eza
	wev
	gh
	tealdeer
    	trash-cli 
	calibre 
	google-chrome
	bat 
	ugrep 
	# zsh 
	python312Packages.jupyter
	keepassxc 
	swaybg 
	swaylock 
	mpv  
	android-tools 
	# hyprland 
	wofi 
	waybar 
	pyprland 
	font-awesome_4
	swaylock  
	copyq 
	networkmanagerapplet 
	grimblast 
	hyprpolkitagent 
	starship 
	lazygit 
	keyd 
	nextcloud-client 
	qbittorrent
	wlogout
	nwg-look
	# oh-my-zsh
    ];

  };

  # # Install firefox.
  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    git
    yazi
    nerdfonts
    alacritty
    stow
    zsh
    # greetd.tuigreet
    # kdePackages.sddm

#     = {
#           enable = true;
#     #       theme = "catppuccin-mocha";
#     #       package = pkgs.kdePackages.sddm;
#         };

    # zsh
#     catppuccin-sddm.override {
#       flavor = "mocha";
#       font  = "Noto Sans";
#       fontSize = "9";
#       # background = "${./wallpaper.png}";
#       loginBackground = true;
#     }
    
  ];

  fonts.fontconfig.useEmbeddedBitmaps = true;
  fonts.enableDefaultPackages = true;
  fonts.packages = with pkgs; [
    # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "JetBrainsMono" "NerdFontsSymbolsOnly" ]; })
    nerdfonts
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.ohMyZsh.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

}
