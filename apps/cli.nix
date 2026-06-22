{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # programming
    android-tools
    devenv
    dos2unix
    ghostscript
    git-lfs
    grc
    guile
    javaPackages.compiler.temurin-bin.jdk-17
    javaPackages.compiler.temurin-bin.jdk-21
    javaPackages.compiler.temurin-bin.jdk-25
    python3
    # files
    cifs-utils
    exfatprogs
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
    mono
    wineWow64Packages.stable
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

  # Enable wireshark
  programs.wireshark.enable = true;
}
