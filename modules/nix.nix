{
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
}
