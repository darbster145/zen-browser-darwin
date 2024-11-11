{ lib
, stdenv
, fetchurl
, makeWrapper
, undmg
}:

let
  pname = "zen";
  versions = {
    darwin = "1.0.1-a.19";
  };
  meta = with lib; {
    description = "Zen Browser";
    homepage = "https://zen-browser.app/";
    license = licenses.free;
    platforms = [ "aarch64-darwin" ];
  };

  appName = "Zen Browser.app";
in
stdenv.mkDerivation {
  pname = pname;
  version = versions.darwin;

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/1.0.1-a.19/zen.macos-aarch64.dmg";
    hash = "sha256-Io95pXzIB3r0bOVAcAizIZPhsBgj6vf6J6IcOfNAtM8=";
  };

  nativeBuildInputs = [ undmg makeWrapper ];

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
    cp -R "Zen Browser.app" "$out/Applications/${appName}"
    makeWrapper "$out/Applications/${appName}/Contents/MacOS/zen" "$out/bin/zen-browser"
    runHook postInstall
  '';

  meta = meta;
}

