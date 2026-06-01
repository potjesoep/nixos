{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prismlauncher
    xonotic
    mcaselector
  ];

  programs.steam.enable = true;
}
