{
  stdenv,
  nerd-font-patcher,
  ...
}:

stdenv.mkDerivation rec {
  pname = "sf-mono-nerd-font";
  version = nerd-font-patcher.version; 
  nativeBuildInputs = [ nerd-font-patcher ];
  src = ./.;

  buildPhase = ''
    mkdir build
    if [ ${version} = $(cat ./cache/version.txt) ]; then
      cp ./cache/share/fonts/opentype/*.otf ./build
    else
      find ./sf-mono -name \*.otf -exec nerd-font-patcher -c -out ./build {} \;
      find ./sf-mono -name \*.otf -exec nerd-font-patcher -c --mono -out ./build {} \;
    fi
  '';

  installPhase = ''
    mkdir -p $out/share/fonts/opentype
    cp ./build/*.otf $out/share/fonts/opentype
    echo ${version} > $out/version.txt
  '';

  meta = {
    description = "Apple's SF Mono font patched with the Nerd Fonts patcher";
  };
}
