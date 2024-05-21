{
  # CHANGE: intel_iommu enables iommu for intel CPUs with VT-d
  # use amd_iommu if you have an AMD CPU with AMD-Vi
  boot.kernelParams = [ "amd_iommu=on" ];
    
  # These modules are required for PCI passthrough, and must come before early modesetting stuff
  boot.kernelModules = [ "vfio" "vfio_iommu_type1" "vfio_pci" ];
  
  # CHANGE: Don't forget to put your own PCI IDs here
  boot.extraModprobeConfig ="options vfio-pci ids=8086:2723";
}
