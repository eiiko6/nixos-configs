{ config, pkgs, ... }:

{
  users.users = {
    strawberries = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "5487";
    };
  };
}
