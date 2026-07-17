{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    bitwarden-cli
    maliit-keyboard
    monero-gui
    # device utils
    arduino-ide
    nitrokey-app2
    qmapshack
    qmk
    rockbox-utility
    solaar
    vial
    # 3d printing
    #TODO: uncomment when fixed
    #freecad-qt6
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
    # programming
    jetbrains.idea
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
