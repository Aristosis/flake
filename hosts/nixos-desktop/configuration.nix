{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  networking.hostName = "nixos-desktop";

  imports =
    [
      ../default.nix
      ./hardware-configuration.nix
      ./stylix.nix
    ]
    ++ builtins.attrValues (import "${inputs.self}/modules/nixos/default.nix");

  features = {
    desktop.enable = true;
    colemak.enable = true;
    sshRemote.enable = true;
    zram.enable = true;
    graphicsDrivers = {
      enable = true;
      nvidia.enable = true;
    };
    copyparty.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.ari = {
    isNormalUser = true;
    openssh.authorizedKeys.keys = [];
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  system.stateVersion = "26.05";
}
