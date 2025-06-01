{ config, pkgs, inputs, ... }:

{
  users.users = {
    strawberries = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      shell = pkgs.fish;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "strawberries" = import ../home.nix;
    };
  };
}
