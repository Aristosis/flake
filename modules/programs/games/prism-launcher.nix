{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    prismlauncher
    temurin-jre-bin-17
  ];
}
