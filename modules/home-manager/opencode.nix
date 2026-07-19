{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.opencode.enable = lib.mkEnableOption "Enable opencode AI agent thing";

  config = lib.mkIf config.features.home-manager.opencode.enable {
    programs.opencode = {
      enable = true;
      skills.caveman = pkgs.fetchurl {
        url = "https://raw.GitHubusercontent.com/JuliusBrussee/caveman/refs/heads/main/skills/caveman/SKILL.md";
        sha256 = "01c65vfcim958l98xpk49bdihvz7h10shbbgffyh22xxmxbbnc2y";
      };
      # skills.caveman-stats = pkgs.fetchurl {
      #   url = "https://raw.GitHubusercontent.com/JuliusBrussee/caveman/refs/heads/main/skills/caveman-stats/SKILL.md";
      #   sha256 = lib.fakeSha256;
      # };
      # skills.caveman-review = pkgs.fetchurl {
      #   url = "https://raw.GitHubusercontent.com/JuliusBrussee/caveman/refs/heads/main/skills/caveman-review/SKILL.md";
      #   sha256 = lib.fakeSha256;
      # };
      # skills.caveman-help = pkgs.fetchurl {
      #   url = "https://raw.GitHubusercontent.com/JuliusBrussee/caveman/refs/heads/main/skills/caveman-help/SKILL.md";
      #   sha256 = lib.fakeSha256;
      # };
      # skills.caveman-compress = pkgs.fetchurl {
      #   url = "https://raw.GitHubusercontent.com/JuliusBrussee/caveman/refs/heads/main/skills/caveman-compress/SKILL.md";
      #   sha256 = lib.fakeSha256;
      # };
      # skills.caveman-commit = pkgs.fetchurl {
      #   url = "https://raw.GitHubusercontent.com/JuliusBrussee/caveman/refs/heads/main/skills/caveman-commit/SKILL.md";
      #   sha256 = lib.fakeSha256;
      # };
      # skills.commit-commit = pkgs.fetchurl {
      #   url = "https://raw.GitHubusercontent.com/JuliusBrussee/commit/refs/heads/main/skills/commit-commit/SKILL.md";
      #   sha256 = lib.fakeSha256;
      # };
    };
  };
}
