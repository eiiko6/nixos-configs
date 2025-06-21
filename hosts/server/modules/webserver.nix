{ config, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."alatreon.org" = {
      root = "/var/www/home";

      locations."/" = {
        root = "/var/www/home";
        tryFiles = "$uri $uri/ /index.html";
      };

      locations."/portfolio/" = {
        root = "/var/www";
        tryFiles = "$uri $uri/ /portfolio/index.html";
      };

      enableACME = true;
      forceSSL = true;
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "strawberrybloom62@gmail.com";
  };
}
