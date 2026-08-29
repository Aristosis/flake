{
  pkgs,
  ...
}:
{
  programs.zsh = {
    enable = true;

    shellAliases = {
      cat = "bat";
      nrs = "sudo nixos-rebuild switch --flake $HOME/flake";

      ls = "lsd";
      l = "lsd -l";
      ll = "lsd -alh";
      lt = "lsd --tree";
    };

    setOptions = [
        "share_history"
        "inc_append_history"
        "hist_ignore_dups"
        "hist_ignore_space"
        "auto_param_slash"
        "auto_menu"
        "glob_complete"
        "pushd_ignore_dups"
        "prompt_subst"
    ];

    enableGlobalCompInit = false;
    interactiveShellInit =
    ''
    autoload -Uz compinit
    fpath=(''${(ou)fpath}) # Stable fpath order hence consistent cache hit.
    if [[ ! -s ''${ZDOTDIR:-$HOME}/.zcompdump || \
      /run/current-system/sw -nt ''${ZDOTDIR:-$HOME}/.zcompdump ]]; then
        compinit
        zcompile ''${ZDOTDIR:-$HOME}/.zcompdump 2>/dev/null
    else
      compinit -C
    fi


    zstyle ':completion:*' group-name \'\'
    zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}


    ''
    + ''
    source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    ''
    +
    ''
    source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh;
    '';

    promptInit = ''
    git_current_branch() {
      local branch=$(git branch --show-current 2>/dev/null)
      [[ -n $branch ]] && echo " $branch "
    }

    precmd() {
      PROMPT=$'\n%(?..%F{red}[%?]%f )%F{blue}$(git_current_branch)%f%~\n> '
    }
    '';
  };
}
