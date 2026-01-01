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
      device = "/dev/disk/by-label/tree_media";
      fsType = "f2fs";
      options = [ "users" "rw" "nofail" ];
    };
    "/mnt/move" = {
      device = "//192.168.0.1/G";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100,vers=2.0"];
    };
  };
  networking.hostName = "nixos-laptop";
  services.power-profiles-daemon.enable = false;
  services.tlp.enable = true;
  services.xserver.xkb.variant = "workman";
}
