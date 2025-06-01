{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    btop
    cargo
    chezmoi
    eza
    fastfetch
    fish
    gcc
    git
    home-manager
    imagemagick
    mupdf
    neovim
    nodejs_22
    rust-analyzer
    starship
    tmux
    unzip
    vim
    wget
    xfce.thunar
  ];
}
