{
  home.file.".ls_colors".source = ./ls_colors;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      share = true;
      append = true;
      ignoreDups = true;
      ignoreSpace = true;
    };

    shellAliases = {
      vi = "nvim";
      vim = "nvim";
      ll = "eza -lah";
      ls = "eza --icons";
      cat = "bat";
      btw = "fastfetch";
      dlp = ''yt-dlp --extract-audio --audio-format best --embed-metadata --embed-thumbnail --audio-quality 0 -o "%(artist)s - %(track)s.%(ext)s"'';
      nrs = "sudo nixos-rebuild switch --flake $HOME/nix-dotfiles/";
      dots = "git --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles";
      lazydots = "lazygit --git-dir=$HOME/dotfiles/.git --work-tree=$HOME/dotfiles";
    };
    initContent = ''
      source ~/.ls_colors
      setopt auto_param_slash
      setopt auto_menu
      setopt glob_complete
      setopt pushd_ignore_dups
      setopt prompt_subst

      source <(zoxide init zsh --cmd cd)
      source <(fzf --zsh)

      zstyle ':completion:*' group-name \'\'
      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

      git_current_branch() {
        local branch=$(git branch --show-current 2>/dev/null)
          [[ -n $branch ]] && echo  " $branch "
      }

      precmd() {
        PROMPT=$'\n%(?..%F{red}[%?]%f )%F{blue}$(git_current_branch)%f%~\n> '
      }

    '';
  };
}
