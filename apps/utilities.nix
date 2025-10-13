{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    bitwarden
    maliit-keyboard
    monero-gui
    # device utils
    arduino-ide
    nitrokey-app2
    qmapshack
    rockbox-utility
    solaar
    # 3d printing
    openscad
    prusa-slicer
    # files
    filelight
    filezilla
    gearlever
    gparted
    kate
    kdiskmark
    kgpg
    libreoffice-qt
    okteta
  ];

  # Add nitrokey udev rules
  hardware.nitrokey.enable = true;

  # Enable kde partition manager
  programs.partition-manager.enable = true;

  # Enable GnuPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
