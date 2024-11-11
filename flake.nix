{
  description = "Zen Browser Nix package for Darwin";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages = {
      darwin = {
        aarch64 = import ./default.nix {
          inherit (nixpkgs.pkgs) lib fetchurl stdenv makeWrapper undmg;
        };
      };
    };
  };
}

