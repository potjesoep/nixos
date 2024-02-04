{
  description = "System configuration of cuddles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./machines/nixos.nix
        ./modules/amd.nix
        ./modules/boot.nix
        ./modules/desktop.nix
        ./modules/disks.nix
        ./modules/input.nix
        ./modules/locale.nix
        ./modules/networking.nix
        ./modules/nix.nix
        ./modules/nvidia.nix
        ./modules/pci-passthrough.nix
        inputs.home-manager.nixosModules.default
      ];
    };
    nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem {
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
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
