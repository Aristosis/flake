{
  pkgs,
  inputs,
  ...
}:
{
  programs = {
    niri.enable = true;
    foot.enable = true;
    waybar.enable = true;
  };

  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "fuzzel-emojis";
      runtimeInputs = with pkgs; [
        fuzzel
        coreutils
        wtype
      ];
      text = ''
        emojis=$(cat ${inputs.self}/config/emojis)
        selected=$(echo "$emojis" | fuzzel -d -l 20)
        if [ -n "$selected" ]; then
          wtype "$(echo "$selected" | cut -d ' ' -f1)"
        fi
      '';
    })
    awww
    fuzzel
    wl-clipboard
    cliphist
    xwayland-satellite
  ];

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer-pool-in-wayland-compositors.json".text =
    ''
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
