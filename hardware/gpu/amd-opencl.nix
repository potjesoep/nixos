{ pkgs, ...}:

{
  hardware = {
    amdgpu.opencl.enable = true;
    graphics.extraPackages = with pkgs; [
      mesa.opencl
    ];
  };
  
  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
