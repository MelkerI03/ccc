{
  description = "A Haskell-based C compiler called ccc";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        haskellPkgs = pkgs.haskellPackages;
        devTools = [
          haskellPkgs.cabal-install
          haskellPkgs.haskell-language-server
          haskellPkgs.hlint
          haskellPkgs.ormolu
          haskellPkgs.ghcid
        ];
      in
      {
        packages.default = haskellPkgs.callCabal2nix "ccc" ./. {};

        devShells.default = haskellPkgs.shellFor {
          packages = _: [ self.packages.${system}.default ];
          buildInputs = devTools ++ [ pkgs.nixpkgs-fmt ];
          shellHook = ''
            echo "Welcome to the ccc development environment!"
            echo "Available tools: cabal, haskell-language-server, hlint, ormolu, ghcid"
          '';
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/ccc";
        };
      }
    );
}
