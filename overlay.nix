self: super: let
  oldGerbilPackages = if (builtins.hasAttr "gerbilPackages" super)
                      then super.gerbilPackages
                      else {};
  newGerbilPackages = oldGerbilPackages // {
    clojerbil = super.callPackage ./derivation.nix {};
  };
in {
  gerbilPackages = newGerbilPackages;
}
