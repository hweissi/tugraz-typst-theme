{
  description = "LaTeX environment";
  nixConfig.bash-prompt = "\[nix-develop\]$ ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    utils.url = "github:numtide/flake-utils";
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
      in {
        devShell = p.mkShell.override {stdenv = p.stdenv;} rec {
          packages = with p; [
            typst
            typst-lsp
            typst-live
          ];

          name = "Typst build";
        };
      }
    );
}
