# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# { config, pkgs, ... }:
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: # removed 'config' to satisfy lsp, add it if required

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  #   catppuccin.flavor = "mocha";
  #   catppuccin.enable = true;

  # nixvim.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    xdgOpenUsePortal = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;

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
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages =
      with pkgs;
      [
        #  thunderbird
        stow
        linux-wifi-hotspot
        tmux
        brightnessctl
        zoxide
        fzf
        eza
        librewolf
        gcc
        nerdfonts
        obsidian
        starship
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
        nil
        vscode
        tree
        # fm
        cachix
        mercurial
        kando
        ffmpeg
        firefox-beta-bin
        mullvad-browser
        powertop
        wl-clipboard
        nushell
        adwaita-icon-theme
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.qt5.qtgraphicaleffects
        libsForQt5.qt5.qtsvg
        telegram-desktop
        libreoffice-qt6-fresh
        go
        python3

      ]
      ++ [
        inputs.zen-browser.packages."${system}".default
        inputs.firefox-nightly.packages.${pkgs.system}.firefox-nightly-bin
      ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    with pkgs;
    [
      #  wget
      git
      keyd
      yazi
      killall
      alacritty
      mako
      qt5.qtwayland
      qt6.qtwayland
      libnotify
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr

    ]
    ++ [
      inputs.nixvim.packages.${system}.default
      inputs.ghostty.packages.${system}.default
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Keyd service
  services.keyd.enable = true;

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;

  # Install firefox.
  programs.firefox.enable = true;

  fonts.packages = with pkgs; [
    nerdfonts
  ];
  fonts.enableDefaultPackages = true;

  services.flatpak.enable = true;

  security.polkit.enable = true;

  # services.tlp.enable = true;
  services.power-profiles-daemon.enable = false; # Default is true, it conflicts with tlp

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      #       CPU_MIN_PERF_ON_AC = 0;
      #       CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      #       # Optional helps save long term battery health
      #       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      #       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

    };
  };

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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
