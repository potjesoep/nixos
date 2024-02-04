{ config, lib, ... }:

{
  networking.hostName = "nixos-laptop";
  environment.variables.VDPAU_DRIVER = "radeonsi";
  services.xserver.xkb.variant = "workman";
  console.earlySetup = true;
  console.useXkbConfig = true;
}
