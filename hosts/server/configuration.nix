{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.default
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "Alatreon";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 49153 ];
    };
  };

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Users
  users.users = {
    strawberries = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "4587";
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "strawberries" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  system.stateVersion = "24.11"; # Did you read the comment?

  # Services
  services = {
    openssh.enable = true;
  };

  # Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk-sans
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];

    fontconfig.defaultFonts = {
      monospace = [ "Fira Code SemiBold" ];
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

  # Minecraft server
  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers = {
      vanilla-survival = {
        enable = true;
        package = pkgs.paperServers.paper-1_21_4;

        serverProperties = {
          server-port = 49153;
          gamemode = "survival";
          difficulty = "hard";
          simulation-distance = 25;
          view-distance = 25;
        };
      };
    };
  };

  # Environment variables and system packages
  environment = {
    systemPackages = with pkgs; [
      btop
      cargo
      chezmoi
      eza
      fastfetch
      fish
      gcc
      git
      imagemagick
      kitty
      mupdf
      neovim
      networkmanagerapplet
      nodejs_22
      python39
      pywal
      rust-analyzer
      starship
      tmux
      unrar
      unzip
      vim
      wget
      wl-clipboard
      wofi
      xfce.thunar
    ];
  };
}
