{ config, ... }:

{
  services.nginx = {
    enable = true;

    virtualHosts."alatreon.org" = {
      enableACME = true;
      forceSSL = true;

      root = "/var/www/home";

      locations."/" = {
        root = "/var/www/home";
        tryFiles = "$uri $uri/ /index.html";
      };

      locations."/portfolio/" = {
        root = "/var/www";
        tryFiles = "$uri $uri/ /portfolio/index.html";
      };

      locations."/share/" = {
        alias = "/var/www/share/";
        extraConfig = ''
          # autoindex on;
          default_type application/octet-stream;
        '';
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "strawberrybloom62@gmail.com";
  };
}
