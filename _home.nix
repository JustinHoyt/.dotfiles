{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "SUBSTITUTE";
  home.homeDirectory = "/home/SUBSTITUTE";

  imports = [ ./common.nix ];
  # imports = [ ./desktop.nix ];

  home.packages = with pkgs; [
  ];
}
