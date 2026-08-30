{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # users.users.ari = {
  #   isNormalUser = true;
  #   openssh.authorizedKeys = [];
  #   extraGroups = [ "wheel" ];
  # };
  # hjem.users.ari.packages = {};
  hjem.users.ari = {
    enable = true;
    user = "ari";
    directory = "/home/ari";
    clobberFiles = true;
    files =
    let
    config = "${inputs.self}/config/";
    in
    {
      ".config/niri".source   = config + "niri";
      # ".config/foot".source   = config + "foot";
      # ".config/waybar".source = config + "waybar";
      # ".zshrc".source         = config + "zsh/zshrc";
      # xdg.config.files."nvim".source   = config / "nvim";
      # xdg.config.files."mako".source   = config / "mako";
    };
  };
}
