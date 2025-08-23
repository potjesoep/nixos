{
  fileSystems."/boot" = {
    device = "/dev/disk/by-partlabel/part_boot";
    fsType = "vfat";
  };

  boot.initrd = {
    services.lvm.enable = true;
    luks.devices."crypt_root".device = "/dev/disk/by-partlabel/part_root";
    luks.devices."crypt_swap".device = "/dev/disk/by-partlabel/part_swap";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/tree_root";
    fsType = "ext4";
  };

  swapDevices = [
    { device = "/dev/disk/by-label/tree_swap"; }
  ];

  services.fstrim.enable = true;
  services.lvm.enable = true;
}
