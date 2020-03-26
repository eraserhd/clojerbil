{ nixpkgs ? (import ./nixpkgs.nix), ... }:
let
  pkgs = import nixpkgs { config = {}; };
  clojerbil = pkgs.callPackage ./derivation.nix {};
in {
  test = pkgs.runCommandNoCC "clojerbil-test" {} ''
    mkdir -p $out
    : ${clojerbil}
  '';
}