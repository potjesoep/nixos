{ pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cuddles = {
    isNormalUser = true;
    description = "cuddles";
    extraGroups = [
      "adbusers"
      "libvirtd"
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      # utilities
      bitwarden
      discover
      filelight
      gparted
      kate
      libreoffice-qt
      localsend
      maliit-keyboard
      prusa-slicer
      vial
      yakuake
      # online
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      (pkgs.ungoogled-chromium.override {
        enableWideVine = true;
      })
      (pkgs.callPackage ./pkgs/krisp-patch {})
      cinny-desktop
      floorp
      jami
      signal-desktop
      telegram-desktop
      whatsapp-for-linux
      # media
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          looking-glass-obs
          obs-pipewire-audio-capture
          obs-vaapi
          obs-vkcapture
          wlrobs
        ];
      })
      blender
      kdenlive
      mpris-scrobbler
      mpv
      nicotine-plus
      qbittorrent
      spicetify-cli
      spotify
      syncplay
      syncthingtray
      vlc
      xwaylandvideobridge
      # gaming
      (pkgs.tetrio-desktop.override {
        withTetrioPlus = true;
      })
      bottles
      fusee-interfacee-tk
      gamemode
      gamescope
      goverlay
      heroic
      lutris
      mangohud
      prismlauncher
      protonup-qt
      r2modman
      steamtinkerlaunch
      urbanterror
      vintagestory
      vkbasalt
      wineWowPackages.stagingFull
      winetricks
    ];
  };

  # enable replaysorcery on boot, doesn't work with nvidia :(
  #services.replay-sorcery = {
  #  enable = true;
  #  autoStart = true;
  #  enableSysAdminCapability = true;
  #  settings = {
  #    videoInput = "hwaccel"; # requires `services.replay-sorcery.enableSysAdminCapability = true`
  #    videoFramerate = 60;
  #  };
  #};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    (python3.withPackages(ps: with ps; [ pyusb ]))
    appimage-run
    git
    grc
    htop
    lm_sensors
    p7zip
    pypy3
    sddm-kcm
    unzip
    wget
    wl-clipboard
    xclip
    # kde system info deps
    clinfo
    glxinfo
    pciutils
    vulkan-tools
    wayland-utils
    # steamtinkerlaunch deps
    xdotool
    xorg.xhost
    xorg.xwininfo
    xxd
    yad
    # virtualization
    OVMF
    gnome.gnome-boxes
    qemu
  ];
  
  # Enable libvirtd, ovmf and virt-manager
  virtualisation.libvirtd = {
    enable = true;
    qemu.ovmf = {
      enable = true;
    };
  };
  programs.virt-manager.enable = true;
  
  # Enable adb
  programs.adb.enable = true;

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

  # Enable kde partition manager
  programs.partition-manager.enable = true;

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

  # Install steam with firewall rules
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # add udev rules for ns-usbloader as user and sysdvr as user
  programs.ns-usbloader.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="18d1", ATTRS{idProduct}=="4ee0", MODE="0666"
  '';

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
