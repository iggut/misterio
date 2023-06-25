{
  lib,
  stdenv,
  fetchFromGitHub,
  meson,
  ninja,
  pkgconfig,
  wrapGAppsHook,
  gtk3,
  libpulseaudio,
  libmpdclient,
  libxkbcommon,
  gtk-layer-shell,
  json_c,
  glib,
}:
stdenv.mkDerivation rec {
  pname = "sfwbar";
  version = "git";
  src = fetchFromGitHub {
    owner = "LBCrion";
    repo = pname;
    rev = "7ca84cca1b3b919b696dd66aaf5ecd0de60032fe";
    sha256 = "IfPF8jTV3P5sBfhOyycczIkEjbcbfbN5Mdxn9ck9Bi4=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    wrapGAppsHook
  ];

  buildInputs = [
    gtk3
    gtk-layer-shell
    json_c
    glib
    libpulseaudio
    libmpdclient
    libxkbcommon
  ];

  mesonFlags = [
    "-Dbsdctl=disabled"
  ];

  doCheck = false;

  postPatch = ''
    sed -i 's|gio/gdesktopappinfo.h|gio-unix-2.0/gio/gdesktopappinfo.h|' src/scaleimage.c
  '';

  meta = with lib; {
    description = "Sway Floating Window Bar";
    homepage = "https://github.com/LBCrion/sfwbar";
    license = licenses.lgpl21Plus;
    platforms = platforms.unix;
  };
}
