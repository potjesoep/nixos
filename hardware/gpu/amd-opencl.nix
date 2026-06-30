{ pkgs, ...}:

{
  hardware.graphics.extraPackages = with pkgs; [
    #rocmPackages.clr.icd
    mesa.opencl
  ];
  
  environment.systemPackages = with pkgs; [
    clinfo
  ];
}
