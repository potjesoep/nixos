{ config, lib, ... }:

{
  environment.variables.LIBVA_DRIVER_NAME = "radeonsi";
  environment.variables.VDPAU_DRIVER = "va_gl";
  environment.etc.crypttab = {
    mode = "0600";
    text = ''
      crypt_media /dev/disk/by-partlabel/part_media /root/key_media.key nofail
    '';
  };
  fileSystems = {
    "/mnt/media" = {
      device = "/dev/disk/by-label/tree_media";
      fsType = "f2fs";
      options = [ "users" "rw" "nofail" ];
    };
    "/mnt/move" = {
      device = "/dev/disk/by-label/tree_move";
      fsType = "ntfs-3g";
      options = [ "users" "rw" "uid=cuddles" "nofail" ];
    };
  };
  networking.hostName = "nixos-laptop";
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
}
