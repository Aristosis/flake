{ pkgs, ... }:
{
  imports = [
    ./zsh.nix
    ./prism-launcher.nix
  ];
  environment.systemPackages = with pkgs; [
    fzf
    fuzzel
    librewolf
    lsd
    awww
    wl-clipboard
    xwayland-satellite
  ];
  programs = {
    zoxide.enable = true;
    niri.enable = true;
    foot.enable = true;
    waybar.enable = true;
    neovim.enable = true;
    neovim.defaultEditor = true;
    neovim.viAlias = true;
    neovim.vimAlias = true;

    git = {
      enable = true;
      package = pkgs.gitFull;
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
