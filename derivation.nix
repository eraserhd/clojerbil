{ stdenv, fetchFromGitHub, gambit, gerbil, ... }:

stdenv.mkDerivation rec {
  pname = "clojerbil";
  version = "0.1.0";

  src = ./.;

  buildInputs = [ gerbil gambit ];

  installPhase = ''
    mkdir -p $out/bin
    GERBIL_PATH=$out gxi build.ss
  '';

  meta = with stdenv.lib; {
    description = "TODO: fill me in";
    homepage = https://github.com/eraserhd/clojerbil;
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}
