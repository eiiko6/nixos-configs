{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
      packages = with pkgs; [
        tree
      ];
      initialPassword = "4587";
    };
  };

  nixpkgs.config.allowUnfree = true;

  system.copySystemConfiguration = true;
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
    nvidia = {
      # Modesetting is required.
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
    };

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };

    pulseaudio.support32Bit = true;
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
      (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })
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
      NIXOS_OZONE_WL = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      AQ_DRM_DEVICES = "/dev/dri/card1";
    };

    systemPackages = with pkgs; [
      vim
      wget
      neovim
      hyprland
      waybar
      swww
      fish
      kitty
      xfce.thunar
      firefox
      chezmoi
      starship
      git
      pywal
      fastfetch
      imagemagick
      gcc
      btop
      lemurs
      hyprcursor
      brightnessctl
      pavucontrol
      sqlite
      nodejs_22
      python39
      mako
      wofi
      cliphist
      wl-clipboard
      grim
      slurp
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      xdg-desktop-portal
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      fuse3
      blueman
      gtk3
      rust-analyzer
      networkmanagerapplet
      mupdf
      unzip
      unrar
      wireplumber
      lxappearance
      libsForQt5.qt5ct
      libsForQt5.qt5.qtquickcontrols2
      kdePackages.qt6ct
      spotify
      pamixer
      pulseaudio
      graphite-gtk-theme
    ];
  };
}
