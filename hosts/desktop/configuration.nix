{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "Themis";
    networkmanager.enable = true;
    firewall = {
      enable = false;
      # allowedTCPPorts = [ ... ];
      # allowedUDPPorts = [ ... ];
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
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      jack.enable = true;
    };

    libinput.enable = true;

    openssh.enable = true;

    displayManager.sddm = {
        enable = true;
        wayland.enable = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
    };
  };

  # Programs
  programs = {
    firefox.enable = true;

    hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };

  # XDG Portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
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

  # Environment variables and system packages
  environment = {
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    systemPackages = with pkgs; [
      blueman
      brightnessctl
      btop
      cargo
      chezmoi
      cliphist
      eza
      fastfetch
      firefox
      fish
      fuse3
      gcc
      git
      grim
      gtk3
      hyprcursor
      hyprland
      imagemagick
      kdePackages.qt6ct
      kitty
      lemurs
      libsForQt5.qt5.qtquickcontrols2
      libsForQt5.qt5ct
      lxappearance
      mako
      mupdf
      neovim
      networkmanagerapplet
      nodejs_22
      pamixer
      pavucontrol
      pulseaudio
      python39
      pywal
      rust-analyzer
      slurp
      spotify
      sqlite
      starship
      swww
      unrar
      unzip
      vim
      vulkan-loader
      vulkan-tools
      vulkan-validation-layers
      waybar
      wget
      wireplumber
      wl-clipboard
      wofi
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xfce.thunar
    ];
  };
}
