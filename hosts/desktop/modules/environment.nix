{ config, pkgs, ... }:

{
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
      python313
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
    ];
  };
}
