{
  inputs,
  pkgs,
  ...
}: {
  hjem.users.ari.packages = with pkgs; [
    umu-launcher
    (
      import "${inputs.self}/modules/pkgs/gamering.nix" pkgs
    )
  ];
}
