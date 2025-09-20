{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cuddles = {
    isNormalUser = true;
    description = "cuddles";
    packages = with pkgs; [
      rescrobbled
      mpris-scrobbler
    ];
    extraGroups = [
      "adbusers"
      "dialout"
      "input"
      "kvm"
      "libvirt"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "qemu"
      "spice"
      "tty"
      "uucp"
      "wheel"
    ];
  };
}
