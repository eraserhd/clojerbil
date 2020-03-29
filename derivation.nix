{ stdenv, fetchFromGitHub, gambit, gerbil, makeWrapper, ... }:

stdenv.mkDerivation rec {
  pname = "clojerbil";
  version = "0.1.0";

  src = ./.;

  buildInputs = [ gerbil gambit makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    GERBIL_PATH=$out gxi build.ss
    for exe in "$out/bin/"*; do
      wrapProgram "$exe" --prefix GERBIL_LOADPATH : "$out/lib"
    done
  '';

  meta = with stdenv.lib; {
    description = "TODO: fill me in";
    homepage = https://github.com/eraserhd/clojerbil;
    license = licenses.publicDomain;
    platforms = platforms.all;
    maintainers = [ maintainers.eraserhd ];
  };
}
