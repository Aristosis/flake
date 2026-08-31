{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = let
    modules = "${inputs.self}/modules/";
    users = "${modules}/users/";
  in [
    # (modules + "programs")
  ];

  users.users.ari = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [];
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  hjem.users.ari = let
    config = "${inputs.self}/config";
  in {
    enable = true;
    user = "ari";
    directory = "/home/ari";
    clobberFiles = true;
    xdg.config.files = {
      "niri".source = "${config}/niri";
      "waybar".source = "${config}/waybar";
      "foot".source = "${config}/foot";
      "fuzzel".source = "${config}/fuzzel";
      "nvim".source = "/home/ari/flake/config/nvim";
    };
  };
}
