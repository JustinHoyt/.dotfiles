{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "justin";
  home.homeDirectory = "/home/justin";

  imports = [ ./common.nix ];
}
