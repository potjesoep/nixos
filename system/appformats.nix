{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    appimage-run
    discover
  ];

  # Add appimages as a binary type to easily run them
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  # Enable Flatpak support
  services.flatpak.enable = true;
  services.packagekit.enable = true;
  services.fwupd.enable = true;
  fonts.fontDir.enable = true;
}
