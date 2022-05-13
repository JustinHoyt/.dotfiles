{ config, pkgs, ... }:

{
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    tmux
    neovim
    diff-so-fancy
    eternal-terminal
    gh
    go
    jq
    fzf
    lua
    sumneko-lua-language-server
    neovim
    nnn
    nodejs-16_x
    jdk17_headless
    python310
    wget
    zsh
  ];
}
