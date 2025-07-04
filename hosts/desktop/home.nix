{ config, pkgs, ... }:

{
  home.username = "strawberries";
  home.homeDirectory = "/home/strawberries";

  imports = [
    ./home-manager/fish.nix
    ./home-manager/hyprland.nix
  ];

  programs = {
    fish.enable = true;
    starship.enable = true;
    neovim.enable = true;
    tmux.enable = true;
    home-manager.enable = true;
  };

  home.stateVersion = "24.11";
}
