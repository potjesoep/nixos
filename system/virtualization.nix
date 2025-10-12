{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    OVMF
    gnome-boxes
    qemu
    quickemu
    spice-gtk
    swtpm
    usbredir
  ];

  security.wrappers.spice-client-glib-usb-acl-helper = {
    owner = "root";
    group = "root";
    source = "${pkgs.spice-gtk}/bin/spice-client-glib-usb-acl-helper";
  };

  # Enable libvirtd, ovmf and virt-manager
  virtualisation = {
    spiceUSBRedirection.enable = true;
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
      };
    };
  };
  programs.virt-manager.enable = true;
}
