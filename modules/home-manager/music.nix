{
  config,
  lib,
  pkgs,
  ...
}: {
  options.features.home-manager.music.enable = lib.mkEnableOption "Enable music stuff";

  config = lib.mkIf config.features.home-manager.music.enable {
    services.mpd = {
      enable = true;

      musicDirectory = "/home/ari/Media/Music"; 
      network.startWhenNeeded = true;
      extraConfig = ''
        auto_update "yes"
        input {
          plugin "curl"
        }
        audio_output {
          type            "pipewire"
          name            "PipeWire Sound Server"
        }
        audio_output {
          type            "fifo"
          name            "Visualizer Feed"
          path            "/tmp/mpd.fifo"
          format          "44100:16:2"
        }
      '';
    };
    xdg.configHome.rmpc.def.source = ''

         #!enable(implicit_some)
         #!enable(unwrap_newtypes)
         #!enable(unwrap_variant_newtypes)
     (
       default_album_art_path: None,
       show_song_table_header: true,
       draw_borders: true,
       format_tag_separator: " | ",
       browser_column_widths: [20, 40, 40],
       background_color: None,
       text_color: None,
       header_background_color: None,
       modal_background_color: None,
       modal_backdrop: false,
       preview_label_style: (fg: "yellow"),
       preview_metadata_group_style: (fg: "yellow", modifiers: "Bold"),
       tab_bar: (
         enabled: true,
         active_style: (fg: "#1e1e2e", bg: "#b4befe", modifiers: "Bold"),
         inactive_style: (),
       ),
       highlighted_item_style: (fg: "#cba6f7", modifiers: "Bold"),
       current_item_style: (fg: "#1e1e2e", bg: "#b4befe"),
       borders_style: (fg: "#b4befe"),
       symbols: (
         song: "",
         dir: "",
         playlist: "󰲸",
         marker: ">",
         ellipsis: "...",
         song_style: None,
         dir_style: None,
         playlist_style: None,
       ),
       level_styles: (
         info: (fg: "blue", bg: "black"),
         warn: (fg: "yellow", bg: "black"),
         error: (fg: "red", bg: "black"),
         debug: (fg: "light_green", bg: "black"),
         trace: (fg: "magenta", bg: "black"),
       ),
       progress_bar: (
         symbols: ["", "█", "", "█", ""],
         track_style: (fg: "#1e1e2e"),
         elapsed_style: (fg: "#b4befe"),
         thumb_style: (fg: "#b4befe", bg: "#1e1e2e"),
       ),
       scrollbar: (
         symbols: ["│", "█", "▲", "▼"],
         track_style: (),
         ends_style: (),
         thumb_style: (fg: "#b4befe"),
       ),
       song_table_format: [
         (
           prop: (kind: Property(Artist),
             default: (kind: Text("Unknown"))
           ),
           width: "20%",
         ),
         (
           prop: (kind: Property(Title),
             default: (kind: Text("Unknown"))
           ),
           width: "35%",
         ),
         (
           prop: (kind: Property(Album), style: (fg: "white"),
             default: (kind: Text("Unknown Album"), style: (fg: "white"))
           ),
           width: "30%",
         ),
         (
           prop: (kind: Property(Duration),
             default: (kind: Text("-"))
           ),
           width: "15%",
           alignment: Right,
         ),
       ],
       components: {
         "Progress": Split(
           direction: Horizontal,
           panes: [
             (
               size: "10",
               pane: Pane(Property(
                 content: [
                   (kind: Property(Status(Elapsed))),
                   (kind: Text("/")),
                   (kind: Property(Status(Duration))),
                 ]
               )),
             ),
             (
               size: "100%",
               pane: Pane(ProgressBar)
             )
           ]
         ),
         "Top": Split(
           direction: Horizontal,
           panes: [
             (
               size: "20",
               pane: Pane(AlbumArt)
             ),
             (
               size: "100%",
               pane: Split(
                 direction: Vertical,
                 panes: [
                   (
                     size: "3",
                     pane: Pane(Header),
                   ),
                   (
                     size: "2",
                     pane: Split(
                       direction: Horizontal,
                       panes: [
                         (
                           size: "100%",
                           pane: Component("Progress"),
                         ),
                       ]
                     ),
                   ),
                   (
                     size: "3",
                     pane: Pane(Tabs),
                   ),
                 ],
               ),
             ),
           ]
         )
       },
       layout: Split(
         direction: Vertical,
         panes: [
           (
             size: "8",
             pane: Component("Top"),
           ),
           (
             pane: Pane(TabContent),
             size: "100%",
           ),
         ],
       ),
       header: (
         rows: [
           (
             center: [
               (kind: Property(Song(Title)), style: (modifiers: "Bold")),
             ],
             left: [],
             right: []
           ),
           (
             left: [],
             center: [
               (kind: Property(Song(Artist)), style: (fg: "#f38ba8", modifiers: "Bold"), default: (kind: Text("Unknown"), style: (fg: "yellow", modifiers: "Bold"))),
               (kind: Text(" - ")),
               (kind: Property(Song(Album)),
                 default: (kind: Text("Unknown Album"))
               )
             ],
             right: []
           ),
           (
             left: [
               (kind: Text(" ")),
               (kind: Property(Status(StateV2(playing_label: "", paused_label: "", stopped_label: "Stopped"))), style: (fg: "#cba6f7", modifiers: "Bold")),
             ],
             center: [
               (
                 kind: Property(Widget(States(
                   active_style: (fg: "#b4befe", modifiers: "Bold"),
                   separator_style: (fg: "white"))))
                 ),
                 style: (fg: "dark_gray")
               ),
             ],
             right: [
               (kind: Property(Widget(ScanStatus)), style: (fg: "#b4befe")),
               (kind: Property(Widget(Volume)), style: (fg: "#b4befe"))
             ]
           ),
         ],
       ),
       browser_song_format: [
         (
           kind: Group([
             (kind: Property(Track)),
             (kind: Text(" ")),
           ])
         ),
         (
           kind: Group([
             (kind: Property(Artist)),
             (kind: Text(" - ")),
             (kind: Property(Title)),
           ]),
           default: (kind: Property(Filename))
         ),
       ],
       lyrics: (
         timestamp: false
       )
     )
     '';
    programs.rmpc = {
      enable = true;
      config = ''
      #![enable(implicit_some)]
      #![enable(unwrap_newtypes)]
      #![enable(unwrap_variant_newtypes)]
      (
        theme: "def",
        cache_dir: "~/mpd/cache/",
        rewind_to_start_sec: 9999,
        on_song_change: None,
        volume_step: 5,
        max_fps: 60,
        scrolloff: 5,
        keybinds: (
          global: {
            ":":       CommandMode,
            "q":       Quit,
            "~":       ShowHelp,
            "O":       ShowOutputs,
            "P":       ShowDecoders,
            "I":       ShowCurrentSongInfo,

            ".":       VolumeUp,
            ",":       VolumeDown,
            "s":       Stop,
            ">":       NextTrack,
            "<":       PreviousTrack,
            "f":       SeekForward,
            "b":       SeekBack,
            "p":       TogglePause,
            "z":       ToggleRepeat,
            "x":       ToggleRandom,
            "c":       ToggleConsume,
            "v":       ToggleSingle,

            "<Tab>":   NextTab,
            "<S-Tab>": PreviousTab,
            "1":       SwitchToTab("󰀥 Queue"),
            "2":       SwitchToTab(" Find"),
            "3":       SwitchToTab("󰲸 Playlists"),
            "4":       SwitchToTab(" Files"),
          },
          navigation: {
            "k":         Up,
            "j":         Down,
            "h":         Left,
            "l":         Right,
            "<Up>":      Up,
            "<Down>":    Down,
            "<Left>":    Left,
            "<Right>":   Right,
            "<C-d>":     DownHalf,
            "<C-u>":     UpHalf,
            "g":         Top,
            "G":         Bottom,

            "<C-k>":     PaneUp,
            "<C-j>":     PaneDown,
            "<C-h>":     PaneLeft,
            "<C-l>":     PaneRight,

            "a":         Add,
            "A":         AddAll,
            "r":         Rename,
            "i":         FocusInput,
            "K":         MoveUp,
            "J":         MoveDown,
            "D":         Delete,

            "/":         EnterSearch,
            "n":         NextResult,
            "N":         PreviousResult,

            "<Space>":   Select,
            "<C-Space>": InvertSelection,
            "<CR>":      Confirm,

            "<C-c>":     Close,
            "<Esc>":     Close,
          },
          queue: {
            "D":        DeleteAll,
            "<CR>":     Play,
            "<C-s>":    Save,
            "a":        AddToPlaylist,
            "d":        Delete,
            "i":        ShowInfo,
            "C":        JumpToCurrent,
          },
        ),
        search: (
          case_sensitive: false,
          mode: Contains,
          tags: [
            (value: "any",       label: "Any Tag"),
            (value: "title",      label: "Title"),
            (value: "album",      label: "Album"),
            (value: "artist",     label: "Artist"),
            (value: "filename",   label: "Filename"),
          ],
        ),
        artists: (
          album_display_mode: NameOnly,
          album_sort_by: Name,
        ),
        tabs: [
          (
            name: "󰀥 Queue",
            pane: Pane(Queue)
          ),
          (
            name: " Find",
            pane: Pane(Search),
          ),
          (
            name: "󰲸 Playlists",
            pane: Pane(Playlists),
          ),
          (
            name: " Files",
            pane: Pane(Directories),
          ),
        ],
      )
      '';

      };

  };
}
