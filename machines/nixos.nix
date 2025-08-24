{ pkgs, config, lib, ... }:

{
  networking.hostName = "nixos";
  boot = {
    initrd.luks.devices."crypt_five".device = "/dev/disk/by-partlabel/part_five";
    initrd.luks.devices."crypt_more".device = "/dev/disk/by-partlabel/part_more";
    initrd.luks.devices."crypt_quad".device = "/dev/disk/by-partlabel/part_quad";
    supportedFilesystems = [ "ntfs" ];
  };
  fileSystems = {
    "/mnt/huge" = {
      device = "/dev/disk/by-label/tree_huge";
      fsType = "btrfs";
    };
    "/mnt/more" = {
      device = "/dev/disk/by-label/tree_more";
      fsType = "f2fs";
    };
    "/mnt/move" = {
      device = "/dev/disk/by-label/tree_move";
      fsType = "ntfs-3g";
      options = [ "users" "rw" "uid=cuddles" "nofail" ];
    };
    "/mnt/quad" = {
      device = "/dev/disk/by-label/tree_quad";
      fsType = "f2fs";
    };
    "/mnt/five" = {
      device = "/dev/disk/by-label/tree_five";
      fsType = "f2fs";
    };
  };
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}
