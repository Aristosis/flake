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
    copyparty.enable = true;
    zram.enable = true;
    graphicsDrivers = {
      enable = true;
      nvidia.enable = true;
    };
  };

  home-manager = let
    users = "${inputs.self}/users";
  in {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs;};
    users.ari = import "${users}/ari";
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
