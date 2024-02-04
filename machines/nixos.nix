{ config, lib, ... }:

{
  networking.hostName = "nixos";
  boot.initrd.luks.devices."crypt_more".device = "/dev/disk/by-partlabel/part_more";
  boot.initrd.luks.devices."crypt_quad".device = "/dev/disk/by-partlabel/part_quad";
  boot.kernelModules = [ "it87" ];
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/mnt/huge" = {
    device = "/dev/disk/by-label/tree_huge";
    fsType = "btrfs";
  };
  fileSystems."/mnt/more" = {
    device = "/dev/disk/by-label/tree_more";
    fsType = "f2fs";
  };
  fileSystems."/mnt/move" = {
    device = "/dev/disk/by-label/tree_move";
    fsType = "ntfs-3g";
    options = [ "rw" "uid=cuddles" "nofail" ];
  };
  fileSystems."/mnt/quad" = {
    device = "/dev/disk/by-label/tree_quad";
    fsType = "f2fs";
  };
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
};
