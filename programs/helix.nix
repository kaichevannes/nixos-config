{ ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox-material-transparent";
      editor = {
        true-color = true;
        mouse = false;
        line-number = "relative";
        auto-pairs = false;
        rulers = [ 80 ];
      };
      keys.normal = {
        C-g = [
          ":write-all"
          ":insert-output lazygit >/dev/tty"
          ":redraw"
          ":reload-all"
        ];
      };
      keys.normal.space = {
        e = [
          ":sh rm -f /tmp/unique-file-helixyazi"
          ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-helixyazi"
          ":insert-output echo \"x1b[?1049h\" > /dev/tty"
          ":open %sh{cat /tmp/unique-file-helixyazi}"
          ":redraw"
        ];
      };
    };
    languages = {
      language = [
        {
          name = "html";
          formatter.command = "prettier";
          formatter.args = [
            "--parser"
            "html"
          ];
          auto-format = true;
        }
        {
          name = "css";
          formatter.command = "prettier";
          formatter.args = [
            "--parser"
            "css"
          ];
          auto-format = true;
        }
        {
          name = "go";
          formatter.command = "goimports";
          auto-format = true;
        }
        {
          name = "c";
          file-types = [
            "c"
            "h"
          ];
          formatter.command = "clang-format";
          auto-format = true;
        }
        {
          name = "cpp";
          file-types = [
            "cpp"
            "cc"
            "cxx"
            "hpp"
            "hcc"
            "hxx"
          ];
          formatter.command = "clang-format";
          auto-format = true;
        }
        {
          name = "nix";
          formatter.command = "nixfmt";
          auto-format = true;
        }
      ];
    };
    themes = {
      gruvbox-material-transparent = {
        inherits = "gruvbox-material";
        "ui.background" = "none";
      };
    };
  };
}
