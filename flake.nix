{
  description = "Zen Browser Nix package for Darwin";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages = {
      darwin = {
        aarch64 = let
          pkgs = import nixpkgs { system = "aarch64-darwin"; };
        in
          import ./default.nix {
            inherit (pkgs) lib fetchurl stdenv makeWrapper undmg;
          };
      };
    };
  };
}

