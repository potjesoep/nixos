{
  description = "System configuration of cuddles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    scrumplex.url = "github:Scrumplex/nixpkgs/pkgs/v4l2loopback/fix-kernel-6.8";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, unstable, scrumplex, ... }@inputs:
  {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit unstable scrumplex; };
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
          inputs.home-manager.nixosModules.default
        ];
      };
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit unstable scrumplex; };
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
  };
}
