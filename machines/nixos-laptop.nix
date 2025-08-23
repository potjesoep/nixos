{ config, lib, ... }:

{
  boot.initrd.luks.devices."crypt_media".device = "/dev/disk/by-partlabel/part_media";
  console.earlySetup = true;
  console.useXkbConfig = true;
  environment.variables.LIBVA_DRIVER_NAME = "radeonsi";
  environment.variables.VDPAU_DRIVER = "radeonsi";
  fileSystems = {
    "/mnt/media" = {
      device = "/dev/disk/by-label/tree_media";
      fsType = "f2fs";
      options = [
        "users"
        "nofail"
      ];
    };
  };
  networking.hostName = "nixos-laptop";
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.xserver.xkb.variant = "workman";
}
