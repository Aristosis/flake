{ pkgs, ... }:
{
  programs = {
    git.enable = true;
    niri.enable = true;
    neovim.enable = true;
    neovim.defaultEditor = true;

    zsh = {
      enable = true;
      enableGlobalCompInit = false;
      syntaxHighlighting.enable = true;
      autosuggestions.enable = true;
    };

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
