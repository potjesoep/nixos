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

  # Unlock kwallet on login
  security.pam.services.sddm.enableKwallet = true;

  # Enable gtk/wlr/kde desktop portals
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; with kdePackages; [
        xdg-desktop-portal
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
        xdg-desktop-portal-kde
      ];
    };
  };

  # enable calendar support
  programs.kde-pim = {
    enable = true;
    kmail = true;
    kontact = true;
    merkuro = true;
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

  # install nerdfonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
    nerd-fonts.noto
  ];

  # kde system info deps
  environment.systemPackages = with pkgs; with kdePackages; [
    aha
    clinfo
    glxinfo
    kaccounts-integration
    kaccounts-providers
    pciutils
    qtwebengine
    quota
    sddm-kcm
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

}
