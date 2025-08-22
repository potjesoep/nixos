{
  description = "System configuration of cuddles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, ... }@inputs:
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./machines/nixos.nix
          ./modules/amd.nix
          ./modules/boot.nix
          ./modules/desktop.nix
          ./modules/disks.nix
          ./modules/gaming.nix
          ./modules/input.nix
          ./modules/locale.nix
          ./modules/networking.nix
          ./modules/nix.nix
          ./modules/nvidia.nix
          ./modules/pci-passthrough.nix
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
        ];
      };
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./machines/nixos-laptop.nix
          ./modules/amd.nix
          ./modules/boot.nix
          ./modules/desktop.nix
          ./modules/disks.nix
          ./modules/input.nix
          ./modules/locale.nix
          ./modules/networking.nix
          ./modules/nix.nix
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
        ];
      };
    };
  };
}
