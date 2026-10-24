{ pkgs, inputs, pkgsUnstable, config, ... }:
{
  # add home-manager cli
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # lix overlay
  nixpkgs.overlays = [ (final: prev: {
    inherit (final.lixPackageSets.lix_2_96)
      nixpkgs-review
      nix-direnv
      nix-eval-jobs
      nix-fast-build
      colmena;
  }) ];

  # nix settings
  nix = {
    optimise.automatic = true;
    package = pkgs.lixPackageSets.lix_2_96.lix;
    settings = {
      # enable flakes
      experimental-features = [ "nix-command" "flakes" ];
      # cuda cachix package cache
      substituters = [ "https://cache.nixos-cuda.org" ];
      trusted-public-keys = [ "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M=" ];
      trusted-users = [ "root" "cuddles" ];
    };
    # Auto garbage-collect nix store every day, keep the 5 most recent generations
    #gc = {
    #  automatic = true;
    #  dates = "daily";
    #  options = "--delete-older-than +5";
    #};
  };

  # install nix helper, set nh clean to gc gens > 1 week old and keep 5 most recent gens
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
