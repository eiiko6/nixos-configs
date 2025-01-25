{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
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
      	];
      };
    };
  };
}
