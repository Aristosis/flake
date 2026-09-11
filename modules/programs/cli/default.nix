{ pkgs, ... }: {
  imports = [
    ./zsh.nix
    ./direnv.nix
    ./nh.nix
  ];

  environment.systemPackages = with pkgs; [
    btop
    fzf
    duf
    p7zip
    lsd
    tree-sitter
    bat
    fd
    ripgrep
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
