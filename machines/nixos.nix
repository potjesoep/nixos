{ pkgs, config, lib, ... }:

{
  networking.hostName = "nixos";
  boot = {
    initrd.luks.devices."crypt_quad".device = "/dev/disk/by-partlabel/part_quad";
  };
  fileSystems = {
    "/mnt/huge" = {
      device = "/dev/disk/by-label/tree_huge";
      fsType = "btrfs";
    };
    "/mnt/quad" = {
      device = "/dev/disk/by-label/tree_quad";
      fsType = "f2fs";
      options = [ "nofail" ];
    };
  };
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}
