{
  description = "Nix flake for the Zen Browser on macOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }: let
    packageFor = system: let
      pkgs = import nixpkgs { inherit system; };
    in pkgs.stdenv.mkDerivation rec {
      pname = "zen-browser";
      version = "1.0.2-b.2";

      platformSuffix = if pkgs.stdenv.hostPlatform.system == "aarch64-darwin" then "aarch64" else "x64";

      src = pkgs.fetchurl {
        url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-${platformSuffix}.dmg";
        hash = "sha256-r3H+Fqc1eI0QhNTEolYrR8bqkhsPTc71KQNn2b+z6jY=";
      };

      dontBuild = true;
      dontConfigure = true;
      nativeBuildInputs = [ pkgs.undmg pkgs.makeWrapper ];

      unpackPhase = ''
        undmg "$src"
      '';

      installPhase = ''
        mkdir -p "$out/Applications" "$out/bin"
        cp -R "Zen Browser.app" "$out/Applications/Zen Browser.app"
        makeWrapper "$out/Applications/Zen Browser.app/Contents/MacOS/zen" \
          "$out/bin/${pname}"
      '';

      meta = with pkgs.lib; {
        description = "Firefox-based browser with a focus on privacy and customization";
        homepage = "https://www.zen-browser.app/";
        license = licenses.mpl20;
        platforms = [ "x86_64-darwin" "aarch64-darwin" ];
      };
    };
  in {
    packages.x86_64-darwin = packageFor "x86_64-darwin";
    packages.aarch64-darwin = packageFor "aarch64-darwin";

    defaultPackage.x86_64-darwin = self.packages.x86_64-darwin;
    defaultPackage.aarch64-darwin = self.packages.aarch64-darwin;
  };
}

