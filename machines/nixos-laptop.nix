{ config, lib, ... }:

{
  console.earlySetup = true;
  console.useXkbConfig = true;
  environment.variables.LIBVA_DRIVER_NAME = "radeonsi";
  environment.variables.VDPAU_DRIVER = "radeonsi";
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      crypt_media /dev/disk/by-partlabel/part_media /root/key_media.key nofail
    '';
  };
  fileSystems = {
    "/mnt/media" = {
      device = "/dev/mapper/crypt_media";
      fsType = "f2fs";
      options = [ "users" "rw" "uid=cuddles" "nofail" ];
    };
  };
  networking.hostName = "nixos-laptop";
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.xserver.xkb.variant = "workman";
}
