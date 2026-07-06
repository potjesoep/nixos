{ pkgs, ...}:

{
  hardware = {
    amdgpu.opencl.enable = true;
    graphics.extraPackages = with pkgs; [
      libvdpau-va-gl
      mesa.opencl
    ];
  };
  
  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
