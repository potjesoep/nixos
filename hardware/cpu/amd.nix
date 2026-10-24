{ config, lib, ... }:

{
  boot.kernelModules = [ "kvm-amd" "k10temp" ];
  hardware.cpu.amd = {
    ryzen-smu.enable = true;
    updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
