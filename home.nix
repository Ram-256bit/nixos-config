{ config, pkgs, ... }:

{
  #   # Home Manager needs a bit of information about you and the
  #   # paths it should manage.
  home.username = "ram";
  home.homeDirectory = "/home/ram";
  #
  #   home.packages = with pkgs; [
  #     adw-gtk3
  #   ];
  #
  gtk = {
    enable = true;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    iconTheme = {
      name = "Papirus-Dark";
    };
  };
  #
  # dconf.settings = {
  #   "org/gnome/desktop/interface" = {
  #     color-scheme = "prefer-dark";
  #     gtk-theme = "adw-gtk3-dark";
  #   };
  # };
  #
  #   # This value determines the Home Manager release that your
  #   # configuration is compatible with. This helps avoid breakage
  #   # when a new Home Manager release introduces backwards
  #   # incompatible changes.
  #   #
  #   # You can update Home Manager without changing this value. See
  #   # the Home Manager release notes for a list of state version
  #   # changes in each release.
  home.stateVersion = "24.11";
  #
  #   # Let Home Manager install and manage itself.
  #   programs.home-manager.enable = true;
}
