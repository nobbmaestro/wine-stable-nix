{
  lib,
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation rec {
  pname = "wine-stable";
  version = "11.0_1";

  src = fetchurl {
    url = "https://github.com/Gcenx/macOS_Wine_builds/releases/download/${version}/wine-stable-${version}-osx64.tar.xz";
    sha256 = "b50dc50ec7f41d58b115a6b685d4d1315ba3c797bd3aa0f49213f2703cb82388";
  };

  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/Applications/Wine Stable.app"
    cp -R Contents "$out/Applications/Wine Stable.app/"

    mkdir -p "$out/bin"
    for f in "$out/Applications/Wine Stable.app/Contents/Resources/wine/bin/"*; do
      ln -s "$f" "$out/bin/$(basename "$f")"
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Wine builds for macOS (Gcenx)";
    homepage = "https://github.com/Gcenx/macOS_Wine_builds";
    license = licenses.lgpl21Plus;
    mainProgram = "wine";
    platforms = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
