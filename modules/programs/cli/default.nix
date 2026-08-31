{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./direnv.nix
  ];

  environment.systemPackages = with pkgs; [
    fzf
    duf
    p7zip
    lsd
    tree-sitter
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
