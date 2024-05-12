{ config, lib, ... }:

{
  networking.hostName = "nixos-laptop";
  environment.variables.VDPAU_DRIVER = "radeonsi";
  environment.variable.LIBVA_DRIVER_NAME = "radeonsi";
  console.earlySetup = true;
  console.useXkbConfig = true;
  services.xserver.xkb.variant = "workman";
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
}
