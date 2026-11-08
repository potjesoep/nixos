{ pkgs, config, lib, ... }:

{
  networking.hostName = "nixos-server";
  boot = {
    initrd.luks.devices."crypt_quad".device = "/dev/disk/by-partlabel/part_quad";
    initrd.luks.devices."crypt_sata".device = "/dev/disk/by-partlabel/part_sata";
  };
  fileSystems = {
    "/mnt/quad" = {
      device = "/dev/disk/by-label/tree_quad";
      fsType = "btrfs";
    };
    "/mnt/sata" = {
      device = "/dev/disk/by-label/tree_sata";
      fsType = "btrfs";
    };
  };
}
