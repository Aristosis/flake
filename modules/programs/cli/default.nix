{pkgs, ...}: {
  imports = [
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    fzf
    duf
    p7zip
    lsd
  ];

  programs = {
    zoxide.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };

    git = {
      enable = true;
      package = pkgs.gitFull;
    };
  };
}
