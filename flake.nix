{
  description = "System configuration of cuddles";

  inputs = {
    nixpkgs-patcher.url = "github:gepbird/nixpkgs-patcher";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-patch-audacity-qt612-fix-build = {
      url = "https://github.com/NixOS/nixpkgs/pull/577022.diff";
      flake = false;
    };
    nixpkgs-patch-handbrake-ffmpeg8-fix-build = {
      url = "https://github.com/NixOS/nixpkgs/pull/576407.diff";
      flake = false;
    };
    nixpkgs-patch-linux-modules-ryzen-smu-fix-build = {
      url = "https://github.com/NixOS/nixpkgs/pull/576504.diff";
      flake = false;
    };
    nixpkgs-patch-linux-modules-v4l2loopback-fix-build = {
      url = "https://github.com/NixOS/nixpkgs/pull/575861.diff";
      flake = false;
    };
    nixpkgs-patch-nvidia-split-patchelf-invoke = {
      url = "https://github.com/NixOS/nixpkgs/pull/576397.diff";
      flake = false;
    };
    nixpkgs-patch-python-fix-makewrapperargs-fix-build = {
      url = "https://github.com/NixOS/nixpkgs/pull/575801.diff";
      flake = false;
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, home-manager, lanzaboote, nixpkgs, nixpkgs-patcher, spicetify-nix, ... }@inputs:
  {
    nixosConfigurations = {
      nixos = nixpkgs-patcher.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./apps/cli.nix
          ./apps/gaming.nix
          ./apps/media.nix
          ./apps/online.nix
          ./apps/programming.nix
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
        specialArgs = inputs // { inherit inputs; };
      };
      nixos-laptop = nixpkgs-patcher.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./apps/cli.nix
          ./apps/gaming.nix
          ./apps/media.nix
          ./apps/online.nix
          ./apps/programming.nix
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
        specialArgs = inputs // { inherit inputs; };
      };
    };
  };
}
