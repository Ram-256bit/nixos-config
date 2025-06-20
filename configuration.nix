# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# { config, pkgs, ... }:
{
  config,
  pkgs,
  pkgsUnstable,
  inputs,
  # removed 'config', 'lib' to satisfy lsp, add it if required
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  #  ###### Disable Nvidia dGPU completely
  #  boot.extraModprobeConfig = ''
  #    blacklist nouveau
  #    options nouveau modeset=0
  #  '';
  #  services.udev.extraRules = ''
  #    # Remove NVIDIA USB xHCI Host Controller devices, if present
  #    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
  #    # Remove NVIDIA USB Type-C UCSI devices, if present
  #    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
  #    # Remove NVIDIA Audio devices, if present
  #    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
  #    # Remove NVIDIA VGA/3D controller devices
  #    ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
  #  '';
  #  boot.blacklistedKernelModules = [
  #    "nouveau"
  #    "nvidia"
  #    "nvidia_drm"
  #    "nvidia_modeset"
  #  ];
  #  ###### Disable Nvidia dGPU completely

  ###### Nvidia settings ######
  ###### Ref: https://nixos.wiki/wiki/Nvidia ######
  #   hardware.nvidia.prime = {
  #     offload = {
  #       enable = false;
  #       # enableOffloadCmd = true;
  #     };
  #     # Make sure to use the correct Bus ID values for your system!
  #     intelBusId = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #     # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
  #   };
  # services.xserver.videoDrivers = [ "nvidia" ];
  #   hardware.nvidia = {
  #
  #     # Modesetting is required.
  #     #modesetting.enable = true;
  #
  #     # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
  #     # Enable this if you have graphical corruption issues or application crashes after waking
  #     # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
  #     # of just the bare essentials.
  #     #powerManagement.enable = false;
  #
  #     # Fine-grained power management. Turns off GPU when not in use.
  #     # Experimental and only works on modern Nvidia GPUs (Turing or newer).
  #     #powerManagement.finegrained = true;
  #
  #     # Use the NVidia open source kernel module (not to be confused with the
  #     # independent third-party "nouveau" open source driver).
  #     # Support is limited to the Turing and later architectures. Full list of
  #     # supported GPUs is at:
  #     # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
  #     # Only available from driver 515.43.04+
  #     # Currently alpha-quality/buggy, so false is currently the recommended setting.
  #     open = false;
  #
  #     # Enable the Nvidia settings menu,
  #     # accessible via `nvidia-settings`.
  #     nvidiaSettings = true;
  #
  #     # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #     package = config.boot.kernelPackages.nvidiaPackages.stable;
  #   };
  #   ######

  #   catppuccin.flavor = "mocha";
  #   catppuccin.enable = true;

  # nixvim.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.configurationLimit = 10;
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
  services.xserver.enable = false;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  services.xserver.desktopManager.gnome.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
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
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.gdm-password.enableGnomeKeyring = true;
  environment.variables.XDG_RUNTIME_DIR = "/run/user/$UID"; # set the runtime directory
  programs.seahorse.enable = true; # enable the graphical frontend for managing

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;

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
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
      "adbusers"
    ];
    packages =
      with pkgs;
      [
        #  thunderbird
        stow
        tmux
        brightnessctl
        zoxide
        fzf
        eza
        # librewolf
        gcc
        # nerdfonts
        obsidian
        starship
        # gparted
        # kitty
        firefox
        networkmanager_dmenu
        mpv
        libqalculate
        jq
        poppler
        libgcc
        btop
        wev
        gh
        tealdeer
        trash-cli
        calibre
        google-chrome
        bat
        ugrep
        # zsh
        # python312Packages.jupyter
        keepassxc
        swaybg
        swaylock
        # android-tools
        # sdkmanager
        # android-studio
        # android-studio-tools
        # hyprland
        wofi
        waybar
        pyprland
        font-awesome_4
        copyq
        networkmanagerapplet
        grimblast
        hyprpolkitagent
        lazygit
        keyd
        # nextcloud-client
        qbittorrent
        wlogout
        # nwg-look
        nil

        # vscode
        tree
        # fm

        pinta
        homebank
        hyprlang
        masterpdfeditor4
        adwaita-qt
        adwaita-qt6
        papirus-icon-theme
        freefilesync
        wineWowPackages.waylandFull
        ruff
        pyright
        librewolf
        thunderbird-latest
        anydesk
        kdePackages.akregator
        # qalculate-gtk
        dig
        clang
        # inkscape
        # appimage-run
        signal-desktop
        # ani-cli
        aria2
        yt-dlp
        ani-skip
        gnupatch

        stylua
        ripgrep
        fd
        viu
        chafa
        ueberzugpp
        unzip
        wget
        jdk
        cargo

        marksman
        rust-analyzer
        nixfmt-rfc-style
        vscode-langservers-extracted

        perf-tools
        pciutils
        topgrade
        fastfetch
        # opensnitch-ui
        # opensnitch
        intel-gpu-tools
        # ventoy-full # Known issue: Ventoy uses binary blobs which can't be trusted to be free of malware or compliant to their licenses. ref: https://github.com/NixOS/nixpkgs/issues/404663
        cachix
        lshw
        # mercurial
        # kando
        # obs-studio
        ffmpeg
        # firefox-beta-bin
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
        poetry
        pipx
        # zed-editor
        vscode
        # nodejs_23
        nodejs_20
        mongodb-compass

        #Neovim lsp and other dependencies
        #
        #

        vtsls
        lua-language-server

        bruno
      ]
      ++ [
        inputs.zen-browser.packages."${system}".default

      ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    with pkgs;
    [
      ghostty
      gparted
      distrobox
      libsForQt5.qt5ct
      libsForQt5.breeze-qt5
      # wget
      inter-nerdfont
      # android-studio
      # flutterPackages-source.v3_26
      qemu
      quickemu
      neovim
      git
      keyd
      yazi
      killall
      alacritty
      mako
      libsecret # Required for gnome keyring unlocking
      qt5.qtwayland
      qt6.qtwayland
      libnotify
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      # linuxKernel.packages.linux_libre.perf
      # linuxKernel.packages.linux_libre.cpupower
      linuxKernel.packages.linux_6_12.perf
      linuxKernel.packages.linux_6_12.cpupower
      linux-wifi-hotspot
      # ghostty
      # wgcf

      # auto-cpufreq
      libva
      intel-media-driver # for newer Intel GPUs (UHD)
      vaapiVdpau
      libvdpau-va-gl

    ]
    ++ [
      # inputs.nixvim.packages.${system}.default
      #      inputs.ghostty.packages.${system}.default
    ];

  # services.xserver.videoDrivers = [
  #   "nvidia"
  #   "modesetting"
  # ];
  # hardware.nvidia = {
  #   open = true;
  #   prime = {
  #     offload.enable = true;
  #     offload.enableOffloadCmd = true;
  #     intelBusId = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  # };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vaapiIntel # fallback for older Intel chips
      intel-vaapi-driver # for older Intel chips
    ];
  };

  programs.fish.enable = true;

  services.postgresql.enable = true;

  programs.kdeconnect.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;

  services.mongodb.enable = true;
  services.mongodb.package = pkgs.mongodb-ce;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # services.cloudflare-warp.enable = true;
  programs.adb.enable = true;
  systemd.tmpfiles.rules = [ "L+ /var/lib/qemu/firmware - - - - ${pkgs.qemu}/share/qemu/firmware" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Keyd service
  services.keyd.enable = true;

  programs.zsh.enable = true;
  programs.zsh.ohMyZsh.enable = true;

  # Install firefox.
  # programs.firefox.enable = true;

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.droid-sans-mono
    pkgs.nerd-fonts.jetbrains-mono
  ];

  fonts.enableDefaultPackages = true;

  services.flatpak.enable = true;

  security.polkit.enable = true;

  # services.tlp.enable = true;
  services.power-profiles-daemon.enable = false; # Default is true, it conflicts with tlp

  services.cpupower-gui.enable = true;

  services.auto-cpufreq.enable = true;

  #   services.tlp = {
  #     enable = true;
  #     settings = {
  #       CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #       CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
  #
  #       CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #       CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
  #
  #       #       CPU_MIN_PERF_ON_AC = 0;
  #       #       CPU_MAX_PERF_ON_AC = 100;
  #       CPU_MIN_PERF_ON_BAT = 0;
  #       CPU_MAX_PERF_ON_BAT = 20;
  #
  #       #       # Optional helps save long term battery health
  #       #       START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
  #       #       STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
  #
  #     };
  #   };

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
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
