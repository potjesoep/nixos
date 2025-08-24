{ pkgs, ... }:
{
  # add home-manager cli
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  # enable lix
  nix.package = pkgs.lixPackageSets.latest.lix;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto optimize nix store
  nix.optimise.automatic = true;

  # Auto garbage-collect nix store older than 30days every week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
