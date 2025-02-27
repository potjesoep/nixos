{ pkgs, lib, ... }:

{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager = {
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
    #autoLogin = {
    #  enable = true;
    #  user = "cuddles";
    #};
    # Use wayland plasma session by default
    defaultSession = "plasma";
  };
  services.desktopManager.plasma6.enable = true;

  # Enable KDE Connect
  programs.kdeconnect.enable = true;

  # Unlock kwallet on login
  security.pam.services.sddm.enableKwallet = true;

  # Enable gtk/wlr/kde desktop portals
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; with kdePackages; [
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
    #nativeMessagingHosts.packages = [ pkgs.kdePackages.plasma-browser-integration ];
  };

  # kde system info deps
  environment.systemPackages = with pkgs; [
    aha
    clinfo
    glxinfo
    pciutils
    quota
    vulkan-tools
    wayland-utils
  ];

  # Fix wayland black screens
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "0";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      #cnijfilter2
    ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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
}
