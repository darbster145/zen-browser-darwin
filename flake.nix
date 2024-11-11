{
  description = "Zen Browser Nix package for Darwin";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: {
    packages.darwin = {
      aarch64 = nixpkgs.lib.mkFlake { inherit self; packages = { zen = import ./default.nix; }; };
    };
  };
}

