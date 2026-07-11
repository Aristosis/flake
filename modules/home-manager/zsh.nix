{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.zsh.enable = lib.mkEnableOption "Enable zsh";

  config = lib.mkIf config.features.home-manager.zsh.enable {
    home.packages = with pkgs; [
      zsh-fzf-tab
    ];

    programs.zsh = {
      enable = true;

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
        dlp = ''yt-dlp --extract-audio --audio-format best --embed-metadata --embed-thumbnail --audio-quality 0 -o "%(artist)s - %(track)s.%(ext)s"'';
        nrs = "sudo nixos-rebuild switch --flake $HOME/flake";
      };

      # Use cached compinit. Only rebuild if system generation newer than current cache
      completionInit = ''
        autoload -Uz compinit
        fpath=(''${(ou)fpath}) # Stable fpath order hence consistent cache hit.
        if [[ ! -s ''${ZDOTDIR:-$HOME}/.zcompdump || \
          /run/current-system/sw -nt ''${ZDOTDIR:-$HOME}/.zcompdump ]]; then
            compinit
            zcompile ''${ZDOTDIR:-$HOME}/.zcompdump 2>/dev/null
        else
          compinit -C
        fi
      '';

      initContent = lib.mkMerge [
        (lib.mkOrder 550 "source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh")
        (lib.mkOrder 1000 ''
          setopt auto_param_slash
          setopt auto_menu
          setopt glob_complete
          setopt pushd_ignore_dups
          setopt prompt_subst

          zstyle ':completion:*' group-name \'\'
          zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}

          git_current_branch() {
            local branch=$(git branch --show-current 2>/dev/null)
              [[ -n $branch ]] && echo  " $branch "
          }

          precmd() {
            PROMPT=$'\n%(?..%F{red}[%?]%f )%F{blue}$(git_current_branch)%f%~\n> '
          }
        '')
      ];
    };
  };
}
