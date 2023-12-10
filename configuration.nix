{ pkgs, ... }:

{
  # Enable nix command and flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Auto optimize nix store
  nix.optimise.automatic = true;

  # Auto garbage-collect nix store older than 30days every week
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

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
      "vboxusers"
      "wheel"
    ];
    packages = with pkgs; [
      # utilities
      bitwarden
      discover
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
      schildichat-desktop
      signal-desktop
      telegram-desktop
      whatsapp-for-linux
      # media
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
	  looking-glass-obs
	  obs-vaapi
	  obs-vkcapture
          obs-pipewire-audio-capture
          wlrobs
        ];
      })
      blender
      kdenlive
      mpv
      nicotine-plus
      qbittorrent
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
      goverlay
      heroic
      lutris
      mangohud
      prismlauncher
      protonup-qt
      r2modman
      steamtinkerlaunch
      vintagestory
      vkbasalt
      wineWowPackages.waylandFull
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
    pypy3
    sddm-kcm
    unzip
    wget
    wl-clipboard
    xclip
    # steamtinkerlaunch deps
    xdotool
    xorg.xwininfo
    xxd
    yad
    # virtualization
    OVMF
    gnome.gnome-boxes
    qemu
  ];
  
  # Enable libvirtd, ovmf and virt-manager
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.ovmf = {
        enable = true;
      };
    };
    virtualbox.host.enable = true;
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

  # Set fish as default shell for all users
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  # Use fish as the default shell for the nix-shell command, disabled because it breaks nix-shell
  #environment.variables.NIX_BUILD_SHELL = "fish";

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

  # add udev rules for ns-usbloader as user
  programs.ns-usbloader.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable syncthing
  services.syncthing = {
    enable = true;
    user = "cuddles";
    configDir = "/home/cuddles/.config/syncthing"; # Folder for Syncthing's settings and keys
    dataDir = "/home/cuddles/.config/syncthing/db"; # Folder for Syncthing's database
    openDefaultPorts = true;
  };

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
