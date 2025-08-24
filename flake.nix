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
          ./apps/cli.nix
          ./apps/media.nix
          ./apps/online.nix
          ./apps/sync.nix
          ./apps/utilities.nix
          ./hardware/cpu/amd.nix
          ./hardware/disks.nix
          ./hardware/gpu/nvidia.nix
          ./hardware/gpu/pci-passthrough.nix
          ./hardware/input.nix
          ./hardware/sound.nix
          ./machines/nixos.nix
          ./system/appformats.nix
          ./system/boot.nix
          ./system/desktop.nix
          ./system/locale.nix
          ./system/networking.nix
          ./system/nix.nix
          ./system/virtualization.nix
          ./users/cuddles.nix
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
        ];
      };
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./apps/cli.nix
          ./apps/media.nix
          ./apps/online.nix
          ./apps/sync.nix
          ./apps/utilities.nix
          ./hardware/cpu/amd.nix
          ./hardware/disks.nix
          ./hardware/input.nix
          ./hardware/sound.nix
          ./machines/nixos-laptop.nix
          ./system/appformats.nix
          ./system/boot.nix
          ./system/desktop.nix
          ./system/locale.nix
          ./system/networking.nix
          ./system/nix.nix
          ./system/virtualization.nix
          ./users/cuddles.nix
          home-manager.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
        ];
      };
    };
  };
}
