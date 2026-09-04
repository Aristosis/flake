{ pkgs, ... }: {
  hjem.users.ari.packages = with pkgs; [
    librewolf
  ];
}
