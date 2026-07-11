{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  networking.hostName = "nixos-server";

  imports =
    [
      ./hardware-configuration.nix
      ../default.nix
    ]
    ++ (builtins.attrValues inputs.self.nixosModules);

  users.defaultUserShell = pkgs.zsh;
  users.users = {
    ari = {
      isNormalUser = true;
      openssh.authorizedKeys.keys = [];
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
    };
  };

  features = {
    colemak.enable = true;
    remotesSsh.enable = true;
  };

  system.stateVersion = "26.05";
}
