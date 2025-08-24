{ pkgs, ... }:
{
  # add home-manager cli
  environment.systemPackages = with pkgs; [
    home-manager
  ];


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # nix settings
  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings.experimental-features = [ "nix-command" "flakes" ];
    optimise.automatic = true;
    # Auto garbage-collect nix store older than 14days every week
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
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
