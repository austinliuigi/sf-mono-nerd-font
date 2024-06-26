{
  stdenv,
  nerd-font-patcher,
  ...
}:

stdenv.mkDerivation {
  pname = "sf-mono-nerd-font";
  version = nerd-font-patcher.version; 
  nativeBuildInputs = [ nerd-font-patcher ];
  src = ./sf-mono;

  buildPhase = ''
    mkdir build
    find -name \*.otf -exec nerd-font-patcher -c -out ./build {} \;
    find -name \*.otf -exec nerd-font-patcher -c --mono -out ./build {} \;
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp build/*.otf $out/share/fonts/opentype
  '';

  meta = {
    description = "Apple's SF Mono font patched with the Nerd Fonts patcher";
  };
}
