{ pkgs, ... }:
{
  services = {
    displayManager.ly.enable = true;
    gvfs.enable = true;
  };

  programs.niri.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      inter
      iosevka
      nerd-fonts.symbols-only
    ];
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text = ''
  {
    "rules": [
    {
      "pattern": {
        "feature": "procname",
          "matches": "niri"
      },
        "profile": "Limit Free Buffer Pool On Wayland Compositors"
    }
    ],
      "profiles": [
      {
        "name": "Limit Free Buffer Pool On Wayland Compositors",
        "settings": [
        {
          "key": "GLVidHeapReuseRatio",
          "value": 0
        }
        ]
      }
      ]
  }
  '';

}
