# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./pci-passthrough.nix
  ];

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

  # Bootloader.
  boot.loader = {
    timeout = 1;
    efi = {
      canTouchEfiVariables = true;
    };
    systemd-boot = {
      enable = true;
      consoleMode = "max";
    };
  };

  # Enable plymouth for fancy boot screen.
  boot.initrd.systemd.enable = true;
  boot.kernelParams = [ "quiet" "udev.log_level=3" ];
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  # Use linux_zen and add v4l2loopback for obs virtualcam
  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # Enable networking and bluetooth
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;


  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      settings = {
        Theme = {
	  CursorTheme = "breeze_cursors";
	  CursorSize = 24;
	};
      };
    };
    # Enable automatic login for the user. don't enable with sddm as it does not work
    autoLogin = {
      enable = true;
      user = "cuddles";
    };
    # Use wayland plasma session by default
    defaultSession = "plasmawayland";
  };
  services.xserver.desktopManager.plasma5.enable = true;
  
  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  # Unlock kwallet on login
  security.pam.services.sddm.enableKwallet = true;

  # Enable gtk/wlr/kde desktop portals
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
      ];
    };
  };

  # Enable plasma browser integration and Make Firefox use the KDE file picker. 
  # Preferences source: https://wiki.archlinux.org/title/firefox#KDE_integration
  programs.firefox = {
    enable = true;
    preferences = {
      "widget.use-xdg-desktop-portal.file-picker" = 1;
    };
    # Already enabled by enabling plasma
    #nativeMessagingHosts.packages = [ pkgs.plasma5Packages.plasma-browser-integration ];
  };

  # Fix wayland black screens
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    STEAM_FORCE_DESKTOPUI_SCALING = "1.5";
  };

  # Save display configuration, not needed anymore it seems?
  #services.autorandr.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "euro";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Add bluetooth audio codec support
  environment.etc = {
	"wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
		bluez_monitor.properties = {
			["bluez5.enable-sbc-xq"] = true,
			["bluez5.enable-msbc"] = true,
			["bluez5.enable-hw-volume"] = true,
			["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
		}
	'';
  };

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput = {
    enable = true;
    
    # disabling mouse acceleration
    mouse = {
      accelProfile = "flat";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cuddles = {
    isNormalUser = true;
    description = "cuddles";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      # utilities
      bat
      bitwarden
      discover
      htop
      kate
      prusa-slicer
      vial
      yakuake
      # online
      (pkgs.discord.override {
        withOpenASAR = true;
        withVencord = true;
      })
      (pkgs.callPackage ./krisp-patch.nix {})
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
      qbittorrent
      spotify
      # gaming
      (pkgs.tetrio-desktop.override {
        withTetrioPlus = true;
      })
      bottles
      goverlay
      heroic
      lutris
      mangohud
      prismlauncher
      protonup-qt
      r2modman
      steamtinkerlaunch
      vkbasalt
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    appimage-run
    git
    grc
    lm_sensors
    sddm-kcm
    starship
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
    qemu
    virt-manager
  ];
  
  # Enable libvirtd
  virtualisation.libvirtd.enable = true;
  
  # CHANGE: add your own user here
  users.groups.libvirtd.members = [ "root" "cuddles"];
  
  # CHANGE: use 
  #     ls /nix/store/*OVMF*/FV/OVMF{,_VARS}.fd | tail -n2 | tr '\n' : | sed -e 's/:$//'
  # to find your nix store paths
  virtualisation.libvirtd.qemu.verbatimConfig = ''
    nvram = [ "${pkgs.OVMF}/FV/OVMF.fd:${pkgs.OVMF}/FV/OVMF_VARS.fd" ]
  '';

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

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  #programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable dconf for virt-manager
  programs.dconf.enable = true;

  # Enable avahi with .local domain name resolution
  services.avahi = {
    enable = true;
    # doesn't work for some reason, see below for ipv4 only which does work
    #nssmdns = true;
    openFirewall = true;
  };
  system.nssModules = pkgs.lib.optional true pkgs.nssmdns;
  system.nssDatabases.hosts = pkgs.lib.optionals true (pkgs.lib.mkMerge [
    (pkgs.lib.mkBefore [ "mdns4_minimal [NOTFOUND=return]" ]) # before resolve
    (pkgs.lib.mkAfter [ "mdns4" ]) # after dns
  ]);

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
