{
  description = "NFL Flag Football official management web frontend";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      in {
        devShell = with pkgs; 
          let vscodeWithExtensions = 
            vscode-with-extensions.override {
              vscodeExtensions = with vscode-extensions; [
                bbenoist.nix
                vscodevim.vim
                maximedenes.vscoq
              ];
            };
          in 
            mkShell { 
              buildInputs = [ 
                vscodeWithExtensions
                opam
                coq
              ]; 
            };
      });
}
