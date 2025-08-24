{ config, lib, ... }:

{
  boot.kernelModules = [ "kvm-amd" "k10temp" ];
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
