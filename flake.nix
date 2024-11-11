{
  description = "Zen Browser Nix package for Darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    packages = {
      # Define the package for aarch64-darwin
      aarch64-darwin = let
        pkgs = import nixpkgs { system = "aarch64-darwin"; };

        pname = "zen";
        version = "1.0.1-a.19";
        appName = "Zen Browser.app";

        platformData = {
          url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-aarch64.dmg";
          hash = "sha256-Io95pXzIB3r0bOVAcAizIZPhsBgj6vf6J6IcOfNAtM8=";
        };
      in pkgs.stdenv.mkDerivation {
        pname = pname;
        version = version;

        src = pkgs.fetchurl {
          url = platformData.url;
          hash = platformData.hash;
        };

        nativeBuildInputs = [ pkgs.undmg pkgs.makeWrapper ];

        dontPatch = true;
        dontConfigure = true;
        dontBuild = true;

        unpackPhase = ''
          undmg "$src"
          runHook postUnpack
        '';

        postUnpack = ''
          echo "Contents of Zen Browser.app/Contents/MacOS after undmg extraction:"
          ls -al "Zen Browser.app/Contents/MacOS"
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/Applications" "$out/bin"
          cp -R "${appName}" "$out/Applications/${appName}"
          makeWrapper "$out/Applications/${appName}/Contents/MacOS/zen" "$out/bin/zen-browser"
          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description = "Zen Browser";
          homepage = "https://zen-browser.app/";
          license = licenses.free;
          platforms = [ "aarch64-darwin" ];
        };
      };

      # Define the package for x86_64-darwin
      x86_64-darwin = let
        pkgs = import nixpkgs { system = "x86_64-darwin"; };

        pname = "zen";
        version = "1.0.1-a.19";
        appName = "Zen Browser.app";

        platformData = {
          url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-x64.dmg";
          hash = "sha256-DzlzoEVPZSEr83688Onq9W9bEpz1wohL6r2+Mt2Cxdk=";
        };
      in pkgs.stdenv.mkDerivation {
        pname = pname;
        version = version;

        src = pkgs.fetchurl {
          url = platformData.url;
          hash = platformData.hash;
        };

        nativeBuildInputs = [ pkgs.undmg pkgs.makeWrapper ];

        dontPatch = true;
        dontConfigure = true;
        dontBuild = true;

        unpackPhase = ''
          undmg "$src"
          runHook postUnpack
        '';

        postUnpack = ''
          echo "Contents of Zen Browser.app/Contents/MacOS after undmg extraction:"
          ls -al "Zen Browser.app/Contents/MacOS"
        '';

        installPhase = ''
          runHook preInstall
          mkdir -p "$out/Applications" "$out/bin"
          cp -R "${appName}" "$out/Applications/${appName}"
          makeWrapper "$out/Applications/${appName}/Contents/MacOS/zen" "$out/bin/zen-browser"
          runHook postInstall
        '';

        meta = with pkgs.lib; {
          description = "Zen Browser";
          homepage = "https://zen-browser.app/";
          license = licenses.free;
          platforms = [ "x86_64-darwin" ];
        };
      };
    };

    # Define top-level defaultPackage based on system
    defaultPackage.aarch64-darwin = self.packages.aarch64-darwin;
    defaultPackage.x86_64-darwin = self.packages.x86_64-darwin;
  };
}

