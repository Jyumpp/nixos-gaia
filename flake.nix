{
  description = "Base UGA Module Factory Edge Device Configuration for ZimaBoard";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager?ref=release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosModules.baseEnvironment = {
      imports = [
        home-manager.nixosModules.home-manager 
        ./boot.nix
        ./disks.nix
        ./net.nix
        ./users
      	./sw.nix
      ];
    };
    nixosConfigurations.edgedev1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager 
        ./boot.nix
        ./disks.nix
        ./net.nix
        ./users
      	./sw.nix
        ({ pkgs, lib, home-manager, ... }: {
          networking.hostName = lib.mkForce "edgedev1";
        })
      ];
    };
  };
}
