{
  home-manager.users.sasdelli = {
    pkgs,
    config,
    lib,
    ...
  }: {
    # Kitty configuration
    programs.kitty = lib.mkForce {
      enable = true;

      settings = {
        adjust_line_height = 0;
        adjust_column_width = 0;
        disable_ligatures = "never";

        # Cursor settings
        cursor_shape = "block";
        cursor_beam_thickness = "1.5";
        cursor_underline_thickness = "2.0";
        cursor_stop_blinking_after = "5.0";

        # Window layout settings
        remember_window_size = true;
        initial_window_width = 840;
        initial_window_height = 320;
        enabled_layouts = "tall:bias=50;full_size=1;mirrored=false";
        draw_minimal_borders = true;
        window_padding_width = "12 25 12 25";
        inactive_text_alpha = 1;

        # Tab bar settings
        tab_bar_edge = "top";
        tab_bar_margin_width = 0;
        tab_bar_style = "powerline";
        tab_separator = " ┇ ";
        tab_activity_symbol = "*";
        tab_title_template = "{index}:{title[-8:]}";
        active_tab_title_template = "[{index}:{title[-8:]}]";
        active_tab_font_style = "bold";
        inactive_tab_font_style = "normal";

        # Scrollback settings
        scrollback_lines = 99999;
        scrollback_pager = "${pkgs.coreutils}/bin/less --chop-long-lines --RAW-CONTROL-CHARS +INPUT_LINE_NUMBER";
        scrollback_pager_history_size = 10;

        # Mouse settings
        mouse_hide_wait = "2.0";
        url_style = "curly";
        open_url_modifiers = "ctrl";
        open_url_with = "default";
        url_prefixes = "http https file ftp gemini irc gopher mailto news git";
        detect_urls = "yes";
        copy_on_select = "clipboard";
        strip_trailing_spaces = "smart";
        rectangle_select_modifiers = "ctrl+alt";
        terminal_select_modifiers = "shift";
        pointer_shape_when_grabbed = "beam";
        default_pointer_shape = "arrow";
        pointer_shape_when_dragging = "beam";
      };

      # Keybindings
      keybindings = {
        "ctrl+1" = "goto_tab 1";
        "ctrl+2" = "goto_tab 2";
        "ctrl+3" = "goto_tab 3";
        "ctrl+4" = "goto_tab 4";
        "ctrl+5" = "goto_tab 5";
        "ctrl+6" = "goto_tab 6";
        "ctrl+7" = "goto_tab 7";
        "ctrl+8" = "goto_tab 8";
        "ctrl+9" = "goto_tab 9";
        "ctrl+shift+n" = "launch --location=vsplit";
        "ctrl+shift+l" = "neighboring_window right";
        "ctrl+shift+h" = "neighboring_window left";
        "ctrl+shift+k" = "neighboring_window up";
        "ctrl+shift+j" = "neighboring_window down";
        "ctrl+up" = "scroll_line_up";
        "ctrl+down" = "scroll_line_down";
      };
    };
  };
}
