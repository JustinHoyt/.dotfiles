{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    google-chrome
    nerdfonts
    etcher
    bitwarden
    discord
    kitty
    zoom-us
  ];
}
