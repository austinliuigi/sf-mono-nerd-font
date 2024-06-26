{
  description = "Apple SF Mono Nerd Font";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      # Function used to generate synonymous packages for multiple systems
      #   - param(func) function with argument that takes in the pkgs for a system
      #   - return(attrs) attribute set mapping systems to result of calling func w/ pkgs for that system
      forAllSystems = func:
        nixpkgs.lib.genAttrs [
          "x86_64-linux"
          "aarch64-linux"
        ] (system: func nixpkgs.legacyPackages.${system});
    in {
      packages = forAllSystems (pkgs: rec {
        sf-mono = pkgs.callPackage ./. { };
        default = sf-mono;
      });
    };
}
