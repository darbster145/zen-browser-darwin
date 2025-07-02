{
  description = "Nix flake for the Zen Browser on macOS";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";

  outputs = { self, nixpkgs }:
    let
      packageFor = system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        pkgs.stdenv.mkDerivation rec {
          pname = "zen-browser";
          version = "1.14.1b";

          src = pkgs.fetchurl {
            url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-universal.dmg";
            hash = "sha256-R1EqnnHDdRGs5ZNsvher7C2hA/w964B1iYJubNjR18A=";
          };

          dontBuild = true;
          dontConfigure = true;
          nativeBuildInputs = [ pkgs.undmg pkgs.makeWrapper ];

          unpackPhase = ''
            undmg "$src"
          '';

          installPhase = ''
            mkdir -p "$out/Applications" "$out/bin"
            cp -R "Zen.app" "$out/Applications/Zen.app"
            makeWrapper "$out/Applications/Zen.app/Contents/MacOS/zen" \
              "$out/bin/${pname}"
          '';

          meta = with pkgs.lib; {
            description = "Firefox-based browser with a focus on privacy and customization";
            homepage = "https://www.zen-browser.app/";
            license = licenses.mpl20;
            platforms = [ "x86_64-darwin" "aarch64-darwin" ];
          };
        };
    in
    {
      packages.x86_64-darwin = packageFor "x86_64-darwin";
      packages.aarch64-darwin = packageFor "aarch64-darwin";

      defaultPackage.x86_64-darwin = self.packages.x86_64-darwin;
      defaultPackage.aarch64-darwin = self.packages.aarch64-darwin;
    };
}

