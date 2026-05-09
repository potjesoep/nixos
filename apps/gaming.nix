{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xonotic
  ];
}
