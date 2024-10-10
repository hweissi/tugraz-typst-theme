{
  description = "typst environment";
  nixConfig.bash-prompt = "\[typst\]$ ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
    typst-packages = {
      url = "github:typst/packages";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
    ...
  } @ inputs:
    utils.lib.eachDefaultSystem (
      system: let
        p = import nixpkgs {inherit system;};
        fonts = with p; [
          fira
        ];
        fontPaths = (builtins.map (x: x + "/share/fonts/opentype") fonts) ++ (builtins.map (x: x + "/share/fonts/truetype") fonts) ++ [./fonts];
        fontParam = p.lib.concatStringsSep ":" fontPaths;
        typstPackagesCache = p.stdenv.mkDerivation {
          name = "typst-packages-cache";
          src = "${inputs.typst-packages}/packages";
          dontBuild = true;
          installPhase = ''
            mkdir -p "$out/typst/packages"
            cp -LR --reflink=auto --no-preserve=mode -t "$out/typst/packages" "$src"/*
          '';
        };
        derivation = {stdenvNoCC, ...}:
          stdenvNoCC.mkDerivation {
            name = "main.typ";
            src = ./.;
            buildInputs = [p.typst] ++ fonts;
            buildPhase = ''
              XDG_CACHE_HOME=${typstPackagesCache} TYPST_FONT_PATHS=${fontParam} typst compile main.typ
            '';
            installPhase = ''
              mkdir -p $out
              cp main.pdf $out/main.pdf
            '';
          };
      in {
        devShell = p.mkShell.override {stdenv = p.stdenv;} rec {
          packages = with p;
            [
              typst
              tinymist
              typst-live
            ]
            ++ fonts;

          shellHook = ''
            export TYPST_FONT_PATHS=${fontParam}
          '';

          name = "Typst build";
        };
        packages = {
          default = p.callPackage derivation {};
        };
      }
    );
}
