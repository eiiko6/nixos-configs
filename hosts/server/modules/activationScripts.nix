{ ... }:

{
  system.activationScripts.websharePermissions = {
    text = ''
      mkdir -p /var/www/share
      chown -R root:webshare /var/www/share
      chmod -R 770 /var/www/share
      find /var/www/share -type d -exec chmod g+s {} +
    '';
  };
}
