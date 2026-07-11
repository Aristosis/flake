{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  networking.hostName = "nixos-desktop";

  imports =
    [
      ./hardware-configuration.nix
      ../default.nix
    ]
    ++ (builtins.attrValues inputs.self.nixosModules);

  features = {
    desktop.enable = true;
    colemak.enable = true;
    sshRemote.enable = true;
    graphicsDrivers = {
      enable = true;
      nvidia.enable = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; nixosConfig = config; };

    users.ari = import "${inputs.self}/home-manager/ari/home.nix" ;
  };

  stylix = {
    overlays.enable = false;
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = with pkgs; {
      monospace.package = iosevka;
      monospace.name = "Iosevka";
      serif.package = inter;
      serif.name = "Inter";
      sansSerif.package = inter;
      sansSerif.name = "Inter";
      sizes.applications = 12;
      sizes.terminal = 14;
      sizes.desktop = 13;
      sizes.popups = 14;
    };
    opacity = {
      terminal = 0.9;
      popups = 0.9;
    };
    polarity = "dark";
  };

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


  system.stateVersion = "26.05";
}
