{
  pkgs,
  ...
}:
{
  hjem.users.ari.packages = with pkgs; [
    helvum
    pavucontrol
  ];
}
