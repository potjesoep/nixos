{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    lanzaboote.url = "github:nix-community/lanzaboote";
  };
  outputs = { self, nixpkgs, lanzaboote }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        /etc/nixos/configuration.nix
	lanzaboote.nixosModules.lanzaboote
      ];
    };
  };
}
