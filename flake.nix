{
  description = "Zen Browser Nix package for Darwin";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages = {
      darwin.aarch64 = let
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
      in
        pkgs.callPackage ./default.nix { };
    };
  };
}

