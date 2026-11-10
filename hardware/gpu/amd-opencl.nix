{ pkgs, ...}:

{
  hardware = {
    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
      overdrive.enable = true;
    };
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        libvdpau-va-gl
        rocmPackages.clr.icd
      ];
    };
  };

  # enable rocM support globally
  nixpkgs.config.rocmSupport = true;

  # set location for HIP file to workaround issues
  systemd.tmpfiles.rules =
  let
    rocmEnv = pkgs.symlinkJoin {
      name = "rocm-combined";
      paths = with pkgs.rocmPackages; [
        rocblas
        hipblas
        clr
      ];
    };
  in
  [
    "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    "L+    /opt/amdgpu/share/libdrm/amdgpu.ids   -    -    -     -    ${pkgs.libdrm}/share/libdrm/amdgpu.ids"
  ];

  # opencl info
  environment.systemPackages = with pkgs; [
    clinfo
  ];

  # gpu overclock/undervolt/fan curve tool
  services.lact.enable = true;

  # Set libva driver name for hardware accelerataed video encoding/decoding
  environment.variables = {
    LIBVA_DRIVER_NAME = "radeonsi";
    VDPAU_DRIVER = "va_gl";
  };
}
