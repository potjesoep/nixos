{
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "memtimings";
  version = "0-unstable-2026-09-26";

  src = fetchFromGitHub {
    repo = "MemTimings-Linux";
    owner = "Connor-GH";
    rev = "4a1bac5cc030cd3f72223544407896eb5d7c72ee";
    hash = "sha256-dnENeClk8ezPj23GkcyVKRqZ5z00rmmBqxeXupHBZl8=";
  };

  installPhase = ''
    mkdir -p $out/bin
    mv timings $out/bin
  '';
})
