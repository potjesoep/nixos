{ config, lib, ... }:

{
  boot.kernelModules = [ "kvm-amd" "k10temp" ];
  hardware.cpu.amd = {
    updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # add ryzen-monitor-ng which enables the ryzen-smu kernel driver
  programs.ryzen-monitor-ng.enable = true;
}
