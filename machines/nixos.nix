{ pkgs, config, lib, ... }:

{
  networking.hostName = "nixos";
  boot = {
    initrd.luks.devices."crypt_data".device = "/dev/disk/by-partlabel/part_data";
    initrd.luks.devices."crypt_fast".device = "/dev/disk/by-partlabel/part_fast";
    initrd.luks.devices."crypt_quad".device = "/dev/disk/by-partlabel/part_quad";
    initrd.luks.devices."crypt_sata".device = "/dev/disk/by-partlabel/part_sata";
    initrd.luks.devices."crypt_xtra".device = "/dev/disk/by-partlabel/part_xtra";
  };
  fileSystems = {
    "/mnt/data" = {
      device = "/dev/disk/by-label/tree_data";
      fsType = "xfs";
    };
    "/mnt/fast" = {
      device = "/dev/disk/by-label/tree_fast";
      fsType = "xfs";
    };
    "/mnt/huge" = {
      device = "/dev/disk/by-label/tree_huge";
      fsType = "btrfs";
      options = [ "nofail" ];
    };
    "/mnt/quad" = {
      device = "/dev/disk/by-label/tree_quad";
      fsType = "f2fs";
      options = [ "nofail" ];
    };
    "/mnt/sata" = {
      device = "/dev/disk/by-label/tree_sata";
      fsType = "btrfs";
      options = [ "nofail" ];
    };
    "/mnt/xtra" = {
      device = "/dev/disk/by-label/tree_xtra";
      fsType = "btrfs";
      options = [ "nofail" ];
    };
  };
  #systemd.targets = {
  #  sleep.enable = false;
  #  suspend.enable = false;
  #  hibernate.enable = false;
  #  hybrid-sleep.enable = false;
  #};
}
