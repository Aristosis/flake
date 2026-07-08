{ config, lib, pkgs, ... }:
{
  options.ari.desktop.enable = lib.mkEnableOption "Install and configure desktop programs";

  config = lib.mkIf config.ari.desktop.enable {

    programs = {
      nix-ld = {
        enable = true;
        libraries = with pkgs; [
          zlib
          zstd
          stdenv.cc.cc
          curl
          openssl
          attr
          libssh
          bzip2
          libxml2
          acl
          libsodium
          util-linux
          xz
          systemd
          libxcomposite
          libxtst
          libxrandr
          libxext
          libx11
          libXfixes
          libGL
          libva
          pipewire
          libxcb
          libxdamage
          libxshmfence
          libxxf86vm
          libelf
          glib
          gtk2
          networkmanager
          vulkan-loader
          libgbm
          libdrm
          libxcrypt
          coreutils
          pciutils
          zenity
          libxinerama
          libxcursor
          libxrender
          libxscrnsaver
          libxi
          libsm
          libice
          gnome2.GConf
          nspr
          nss
          cups
          libcap
          SDL2
          libusb1
          dbus-glib
          ffmpeg
          libudev0-shim
          gtk3
          icu
          libnotify
          gsettings-desktop-schemas
          libxt
          libxmu
          libogg
          libvorbis
          SDL
          SDL2_image
          glew110
          libidn
          tbb
          flac
          freeglut
          libjpeg
          libpng
          libpng12
          libsamplerate
          libmikmod
          libtheora
          libtiff
          pixman
          speex
          SDL_image
          SDL_ttf
          SDL_mixer
          SDL2_ttf
          SDL2_mixer
          libappindicator-gtk2
          libdbusmenu-gtk2
          libindicator-gtk2
          libcaca
          libcanberra
          libgcrypt
          libvpx
          librsvg
          libxft
          libvdpau
          pango
          cairo
          atk
          gdk-pixbuf
          fontconfig
          freetype
          dbus
          alsa-lib
          expat
          libxkbcommon
          libxcrypt-legacy
          libGLU
          fuse
          e2fsprogs
          gmp
          harfbuzz
          libgpg-error
          fribidi
          librsvg
          (runCommand "librsvg" {} ''
            mkdir -p $out/lib/gdk-pixbuf-2.0/2.10.0/loaders
            ln -s "${librsvg}/lib/gdk-pixbuf-2.0/2.10.0/loaders/libpixbufloader_svg.so" "$out/lib/libpixbufloader-svg.so"
          '')
          sane-backends
          pkcs11helper
          libpulseaudio
          krb5
          libxcb-cursor
          xcbutilwm
          xcbutil
          xcbutilimage
          xcbutilkeysyms
          xcbutilrenderutil
        ];
      };

      niri.enable = true;
      zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        autosuggestions.enable = true;
      };
    };

    environment.systemPackages = with pkgs; [
      alsa-utils
      copyparty
      ffmpeg-full
      usbutils
      gparted
    ];

  };
}
