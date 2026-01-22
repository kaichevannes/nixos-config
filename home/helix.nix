{ ... }:
{
  programs.helix = {
    enable = true;
    themes = {
      gruvbox-material-transparent = {
        inherits = "gruvbox-material";
        "ui.background" = "none";
      };
    };
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
          name = "go";
          auto-format = true;
          formatter.command = "goimports";
        }
        {
          name = "c";
          auto-format = true;
          file-types = ["c" "h"];
          formatter.command = "clang-format";
        }
        {
          name = "cpp";
          auto-format = true;
          file-types = ["cpp" "cc" "cxx" "hpp" "hcc" "hxx"];
          formatter.command = "clang-format";
        }
      ];
    };
  };
}
