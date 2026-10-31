{
  pkgs
}:

pkgs.stdenv.mkDerivation rec {
  pname = "memtimings";
  version = "4a1bac5";

  src = pkgs.fetchgit {
    url = "https://github.com/Connor-GH/MemTimings-Linux";
    rev = "4a1bac5cc030cd3f72223544407896eb5d7c72ee";
    sha256 = "sha256-dnENeClk8ezPj23GkcyVKRqZ5z00rmmBqxeXupHBZl8=";
  };

  buildInputs = with pkgs; [
    gnumake42
    gcc14
  ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin
    mv timings $out/bin
  '';
}
