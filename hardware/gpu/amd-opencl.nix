{ pkgs, ...}:

{
  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware = {
    amdgpu.opencl.enable = true;
    graphics = {
      enable32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        rocmPackages.clr.icd
      ];
    };
  };

  # set location for HIP file to workaround issues
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  # opencl info
  environment.systemPackages = with pkgs; [
    clinfo
  ];

  # gpu overclock/undervolt/fan curve tool
  services.lact.enable = true;
}
