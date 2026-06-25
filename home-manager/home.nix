{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [];

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
  };

  home = {
    username = "ari";
    homeDirectory = "/home/ari";
  };

  programs = {
    neovim.enable = true;
  };

  home.packages = with pkgs; [ ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  home.stateVersion = "26.11";
}
