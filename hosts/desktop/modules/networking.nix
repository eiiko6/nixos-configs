{ config, ... }:

{
  networking = {
    hostName = "Themis";
    networkmanager.enable = true;
    firewall.enable = false;
  };
}
