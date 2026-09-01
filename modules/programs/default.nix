{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./cli
    ./librewolf.nix
    ./pavucontrol-helvum.nix
    ./games/prism-launcher.nix
    ./games/umu-launcher.nix
  ];
  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        icu
        alsa-lib
        libGL
        libice
        libsm
        libx11
        libxcursor
        libxext
        libxi
        libxinerama
        libxrandr
        libpulseaudio
        libxkbcommon
        wayland
      ];
    };
  };
}
