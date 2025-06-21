{ config, ... }:

{
  networking = {
    hostName = "Alatreon";
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 25565 49152 49153 ];
    };

    interfaces.eno1 = {
      useDHCP = false;
      ipv4.addresses = [{
        address = "192.168.1.155";
        prefixLength = 24;
      }];
    };

    defaultGateway = "192.168.1.254";

    nameservers = [ "1.1.1.1" "8.8.8.8" ];
  };
}
