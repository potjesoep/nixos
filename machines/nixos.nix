{ pkgs, config, lib, ... }:

let
  fanatecff = config.boot.kernelPackages.callPackage ../pkgs/hid-fanatecff {};
in
{
  networking.hostName = "nixos";
  boot = {
    kernelModules = [ "it87" "hid-fanatec" ];
    extraModulePackages = [ fanatecff ];
    initrd.luks.devices."crypt_more".device = "/dev/disk/by-partlabel/part_more";
    initrd.luks.devices."crypt_quad".device = "/dev/disk/by-partlabel/part_quad";
    supportedFilesystems = [ "ntfs" ];
  };
  services.udev.packages = [ fanatecff ];
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
      options = [ "rw" "uid=cuddles" "nofail" ];
    };
    "/mnt/quad" = {
      device = "/dev/disk/by-label/tree_quad";
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
