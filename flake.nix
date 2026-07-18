{
  description = "System configuration of cuddles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, lanzaboote, spicetify-nix, ... }@inputs:
  let
    system = "x86_64-linux";
    unstable = nixpkgs-unstable.legacyPackages.${system};
  in
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
          spicetify-nix.nixosModules.spicetify
        ];
        specialArgs = {
          inherit inputs;
          inherit unstable;
        };
      };
      nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./apps/cli.nix
          ./apps/gaming.nix
          ./apps/media.nix
          ./apps/online.nix
          ./apps/sync.nix
          ./apps/utilities.nix
          ./hardware/cpu/amd.nix
          ./hardware/disks.nix
          ./hardware/gpu/amd-opencl.nix
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
          spicetify-nix.nixosModules.spicetify
        ];
        specialArgs = {
          inherit inputs;
          inherit unstable;
        };
      };
    };
  };
}
