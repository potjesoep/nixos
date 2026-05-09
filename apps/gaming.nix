{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    prismlauncher
    xonotic
  ];
}
