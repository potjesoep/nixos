{ pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; with kdePackages; [
    # recording / editing
    kdenlive
    # music
    audacity
    easyeffects
    fooyin
    freac
    jamesdsp
    mpris-scrobbler
    picard
    playerctl
    puddletag
    rescrobbled
    rsgain
    sacad
    spicetify-cli
    supersonic
    # downloading
    amarok
    kasts
    lrcget
    nicotine-plus
    qbittorrent
    varia
    # pictures
    gimp
    inkscape
    krita
    # video
    (mpv.override {
      scripts = with mpvScripts; [
        autosub
        mpris
        quality-menu
        sponsorblock-minimal
        thumbfast
        uosc
      ];
    })
    (pkgs.ffmpeg-full.override { withUnfree = true; })
    chatterino7
    handbrake
    mkvtoolnix-cli
    streamlink
    syncplay
    twitch-dl
    twitch-hls-client
    twitch-tui
    vlc
    wtwitch
    youtube-tui
    yt-dlp
  ];

  programs.obs-studio = {
    enable = true;
    # add virtual camera support
    enableVirtualCamera = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };

  programs.spicetify =
  let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
  in
  {
    enable = true;
    theme = spicePkgs.themes.default;
    enabledExtensions = with spicePkgs.extensions; [
      #fullAppDisplayMod
      #keyboardShortcut
      shuffle
      #powerBar
      #seekSong
      #fullAlbumDate
      #wikify
      #showQueueDuration
      #copyToClipboard
      #betterGenres
      #lastfm
      hidePodcasts
      #volumePercentage
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      historyInSidebar
      #betterLibrary
    ];
    enabledSnippets = with spicePkgs.snippets; [
      hideDownloadButton
      hideAudiobooksButton
      hideFriendActivityButton
      hideLyricsButton
      hideMadeForYou
    ];
  };
}
