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
        {
          networking.hostName = "nixos";
          boot.initrd.luks.devices."crypt_more".device = "/dev/disk/by-partlabel/part_more";
          boot.kernelModules = [ "it87" ];
          boot.supportedFilesystems = [ "ntfs" ];
          fileSystems."/mnt/more" = {
            device = "/dev/disk/by-label/tree_more";
            fsType = "f2fs";
          };
          fileSystems."/mnt/move" = {
            device = "/dev/disk/by-label/tree_move";
            fsType = "ntfs-3g";
            options = [ "rw" "uid=cuddles" "nofail" ];
          };
          fileSystems."/mnt/huge" = {
            device = "/dev/disk/by-label/tree_huge";
            fsType = "btrfs";
          };
          systemd.targets.sleep.enable = false;
          systemd.targets.suspend.enable = false;
          systemd.targets.hibernate.enable = false;
          systemd.targets.hybrid-sleep.enable = false;
        }
        ./configuration.nix
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
        {
          networking.hostName = "nixos-laptop";
          environment.variables.VDPAU_DRIVER = "radeonsi";
          services.xserver.xkbVariant = "workman";
          console.earlySetup = true;
          console.useXkbConfig = true;
        }
        ./configuration.nix
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
