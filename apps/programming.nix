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
    (pkgs.zulu25.override {
      enableJavaFX = true;
    })
    python3
  ];

  # reverse engineering is sorta like programming
  programs.ghidra.enable = true;
}
