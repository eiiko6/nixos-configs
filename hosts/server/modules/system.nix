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

  # Awkward passwordless command wrapper, just ignore that
  security.sudo.extraRules = [
    {
      users = [ "strawberries" ];
      commands = [
        {
          command = "/usr/bin/passwordless.sh";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  # nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    dust
    xorg.xauth
    firefox
    btop
    cargo
    fd
    ripgrep
    chezmoi
    eza
    fastfetch
    fish
    gcc
    git
    home-manager
    imagemagick
    neovim
    nodejs_22
    rust-analyzer
    starship
    tmux
    unzip
    vim
    wget
    pkg-config
    openssl
  ];
}
