{ nixpkgs ? (import ./nixpkgs.nix), ... }:
let
  pkgs = import nixpkgs {
    config = {};
    overlays = [
      (import ./overlay.nix)
    ];
  };
in {
  test = pkgs.runCommandNoCC "clojerbil-test" {} ''
    mkdir -p $out
    : ${pkgs.clojerbil}
  '';
}
