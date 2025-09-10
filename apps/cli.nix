{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    grc
    # programming
    #(python3.withPackages(ps: with ps; [
      #capstone
      #colorama
      #cryptography
      #docopt
      #keystone-engine
      #lxml
      #passlib
      #pycryptodome
      #pycryptodomex
      #pyserial
      #pyusb
      #qrcode
      #requests
      #wheel
    #]))
    python3
    ghostscript
    guile
    devenv
    # files
    ntfs3g
    samba
    # documents
    pandoc
    groff
    # monitor
    htop
    lm_sensors
    usbutils
    # download
    git
    wget
    # archive
    unrar
    unzip
    p7zip
    # clipboard
    wl-clipboard
    xclip
    # wine
    wineWowPackages.waylandFull
    winetricks
  ];

  # Set fish as default shell for all users and enable fish in nix-shell and nix run
  programs.fish = {
    enable = true;
    promptInit = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };
  users.defaultUserShell = pkgs.fish;

  # Enable neovim and set as default editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  # Enable adb
  programs.adb.enable = true;

  # Enable wireshark
  programs.wireshark.enable = true;
}
