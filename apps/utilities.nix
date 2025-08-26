{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    bitwarden
    maliit-keyboard
    monero-gui
    # device utils
    solaar
    sony-headphones-client
    qmapshack
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
  ];
  
  # Enable kde partition manager
  programs.partition-manager.enable = true;

  # Enable GnuPG agent
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

}
