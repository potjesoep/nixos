{ pkgs, inputs, pkgsUnstable, config, ... }:
{
  # add home-manager cli
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # this allows you to access `pkgsUnstable` anywhere in your config
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  # lix overlay
  nixpkgs.overlays = [ (final: prev: {
    inherit (final.lixPackageSets.stable)
      nixpkgs-review
      nix-direnv
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];

  # nix settings
  nix = {
    binaryCaches = [ "https://cache.nixos.org/" "https://fontis.cachix.org/" ];
    optimise.automatic = true;
    package = pkgs.lixPackageSets.latest.lix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.trusted-users = [ "root" "cuddles" ];
    # Auto garbage-collect nix store older than 14days every week
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    # nix-node simple nodejs shells
    registry."node".to = {
      type = "github";
      owner = "fontis";
      repo = "nix-node";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
