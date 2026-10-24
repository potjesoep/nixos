{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    bitwarden-cli
    bitwarden-desktop
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
    blender
    freecad-qt6
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

  # install nix helper
  programs.nh = {
    enable = true;
    #clean.enable = true;
    #clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos"; # sets NH_OS_FLAKE variable for you
  };

  # Add nitrokey udev rules and GPG support
  hardware.nitrokey.enable = true;
  programs = {
    ssh.startAgent = false;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  # Enable kde partition manager
  programs.partition-manager.enable = true;
}
