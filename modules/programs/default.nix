{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ./zsh.nix
    ./prism-launcher.nix
    ./umu-launcher.nix
  ];
  environment.systemPackages = with pkgs; [
    fzf
    duf
    fuzzel
    librewolf
    lsd
    awww

    wl-clipboard
    cliphist
    xwayland-satellite

    (writeShellApplication {
      name = "fuzzel-emojis";
      runtimeInputs = with pkgs; [fuzzel coreutils wtype];
      text = ''
        emojis=$(cat ${inputs.self}/config/emojis)
        selected=$(echo "$emojis" | fuzzel -d -l 20)
        if [ -n "$selected" ]; then
          wtype "$(echo "$selected" | cut -d ' ' -f1)"
        fi
      '';
    })
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
