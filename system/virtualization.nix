{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    OVMF
    gnome-boxes
    qemu
    swtpm
    spice-gtk
  ];

  security.wrappers.spice-client-glib-usb-acl-helper = {
    owner = "root";
    group = "root";
    source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
  };

  # Enable libvirtd, ovmf and virt-manager
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ (pkgs.OVMFFull.override {
            secureBoot = true;
            tpmSupport = true;
            tlsSupport = true;
            httpSupport = true;
          }) ];
        };
      };
    };
  };
  programs.virt-manager.enable = true;
}
