{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fzf
    fuzzel
    librewolf
    lsd
  ];
  programs = {
    zoxide.enable = true;
    git.enable = true;
    niri.enable = true;
    foot.enable = true;
    waybar.enable = true;
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
