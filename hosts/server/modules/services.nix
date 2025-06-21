{ config, ... }:

{
  services = {
    openssh = {
      enable = true;
      ports = [ 22 49152 ];
      settings = {
        PasswordAuthentication = false;
        AllowUsers = null;
        X11Forwarding = true;
        PermitRootLogin = "no";
      };
    };
    fail2ban = {
      enable = true;
      maxretry = 5;
      bantime = "5m";
    };
  };
}
