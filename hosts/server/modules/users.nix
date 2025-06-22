{ config, pkgs, inputs, ... }:

{
  users = {
    groups.webshare = {};
    users = {
      strawberries = {
        isNormalUser = true;
        extraGroups = [ "wheel" "webshare" ];
        shell = pkgs.fish;
      };

      nginx = {
        extraGroups = [ "webshare" ];
      };
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "strawberries" = import ../home.nix;
    };
  };
}
