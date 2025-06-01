{ config, ... }:

{
  networking = {
    hostName = "Alatreon";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 49152 49153 ];
    };
  };
}
