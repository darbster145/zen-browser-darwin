{
  description = "Zen Browser Nix package for Darwin";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: {
    packages = {
      # Define the default package for aarch64-darwin
      aarch64-darwin = let
        pkgs = import nixpkgs { system = "aarch64-darwin"; };

        pname = "zen";
        version = "1.0.1-a.19";
        appName = "Zen Browser.app";

        platformData = {
          url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-aarch64.dmg";
          hash = "sha256-Io95pXzIB3r0bOVAcAizIZPhsBgj6vf6J6IcOfNAtM8=";
        };
      in { 
        default = pkgs.stdenv.mkDerivation {
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
      };

      # Define the default package for x86_64-darwin
      x86_64-darwin = let
        pkgs = import nixpkgs { system = "x86_64-darwin"; };

        pname = "zen";
        version = "1.0.1-a.19";
        appName = "Zen Browser.app";

        platformData = {
          url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.macos-x64.dmg";
          hash = "sha256-0f3973a0454f65212bf37ebcf0e9eaf56f5b129cf5c2884beabdbe32dd82c5d9";
        };
      in { 
        default = pkgs.stdenv.mkDerivation {
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
    };
  };
}

