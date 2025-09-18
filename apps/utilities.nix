{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    bitwarden
    maliit-keyboard
    monero-gui
    # device utils
    arduino-ide
    qmapshack
    solaar
    sony-headphones-client
    # 3d printing
    openscad
    prusa-slicer
    # files
    filelight
    filezilla
    gparted
    kate
    kgpg
    libreoffice-qt
    okteta
    gearlever
  ];
  
  # Enable kde partition manager
  programs.partition-manager.enable = true;

  # Enable GnuPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
