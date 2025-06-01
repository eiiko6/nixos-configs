{ config, pkgs, ... }:

{
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
}
