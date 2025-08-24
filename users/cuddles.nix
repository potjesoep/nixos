{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cuddles = {
    isNormalUser = true;
    description = "cuddles";
    extraGroups = [
      "adbusers"
      "input"
      "kvm"
      "libvirt"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "qemu"
      "spice"
      "wheel"
    ];
  };
}
