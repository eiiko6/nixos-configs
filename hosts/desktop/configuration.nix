{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./modules/system.nix
    ./modules/networking.nix
    ./modules/users.nix
    ./modules/services.nix
    ./modules/programs.nix
    ./modules/fonts.nix
    ./modules/environment.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "strawberries" = import ./home.nix;
    };
  };

  system.stateVersion = "24.11";
}
