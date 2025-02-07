{ config, pkgs, modulesPath, lib, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Bootloader.
  boot.loader = {
    timeout = 3;
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = lib.mkForce false;
      consoleMode = "max";
    };
  };
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # Enable plymouth for fancy boot screen.
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" "udev.log_level=3" "iwlwifi.bt_coex_active=0" "iwlwifi.power_save=0" "amd_iommu=off" ];
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  # Use linux_zen
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usbhid" "uas" "usb_storage" "sd_mod" ];
  # add v4l2loopback for obs virtualcam
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;
  # udev rules for adb and vial
  services.udev.packages = with pkgs; [
    android-udev-rules
    vial
  ];
}
