{
  description = "System configuration of cuddles";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          networking.hostName = "nixos";
          boot.kernelModules = [ "it87" ];
        }
        ./configuration.nix
        ./modules/amd.nix
        ./modules/boot.nix
        ./modules/desktop.nix
        ./modules/disks.nix
        ./modules/locale.nix
        ./modules/networking.nix
        ./modules/nvidia.nix
        ./modules/pci-passthrough.nix
      ];
    };
    nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        {
          networking.hostName = "nixos-laptop";
          console.earlySetup = true;
          console.useXkbConfig = true;
          services.xserver.xkbVariant = "workman";
        }
        ./configuration.nix
        ./modules/amd.nix
        ./modules/boot.nix
        ./modules/desktop.nix
        ./modules/disks.nix
        ./modules/locale.nix
        ./modules/networking.nix
      ];
    };
  };
}
