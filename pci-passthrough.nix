# put this file in /etc/nixos/
# change the settings tagged with "CHANGE:"
# and add 
#   ./pci-passthrough.nix
# to /etc/nixos/configuration.nix in `imports`

{config, pkgs, ... }:
{  
  # CHANGE: intel_iommu enables iommu for intel CPUs with VT-d
  # use amd_iommu if you have an AMD CPU with AMD-Vi
  boot.kernelParams = [ "amd_iommu=on" ];
    
  # These modules are required for PCI passthrough, and must come before early modesetting stuff
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" ];
  
  # CHANGE: Don't forget to put your own PCI IDs here
  #boot.extraModprobeConfig ="options vfio-pci ids=10de:1e87,10de:10f8,10de:1ad8,10de:1ad9";
}
