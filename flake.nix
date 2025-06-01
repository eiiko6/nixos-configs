{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
  };

  outputs = { self, nixpkgs, home-manager, nix-minecraft, ... }@inputs: {
    nixosConfigurations = {
    	desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
      	modules = [
          ./hosts/desktop/configuration.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
      	];
      };
    	server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
      	modules = [
          ./hosts/server/configuration.nix
          ./hardware-configuration.nix
          home-manager.nixosModules.home-manager
          nix-minecraft.nixosModules.minecraft-servers
      	];
      };
    };
  };
}
