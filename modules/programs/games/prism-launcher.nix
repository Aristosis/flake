{ pkgs, ... }: {
  hjem.users.ari.packages = with pkgs; [
    prismlauncher
    temurin-jre-bin-17
  ];
}
