{ pkgs, ... }:
let
  blockTag = pkgs.writeShellScript "helix_block_tag" ''
    echo "<xxx>"
    cat
    echo "</xxx>"
  '';
  inlineTag = pkgs.writeShellScript "helix_inline_tag" ''
    printf '<xxx>%s</xxx>' "$(cat)"
  '';
in
{
  normal.C-g = [
    ":write-all"
    ":insert-output lazygit >/dev/tty"
    ":redraw"
    ":reload-all"
  ];

  normal.space = {
    e = [
      ":sh rm -f /tmp/unique-file-helixyazi"
      ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-helixyazi"
      ":insert-output echo \"x1b[?1049h\" > /dev/tty"
      ":open %sh{cat /tmp/unique-file-helixyazi}"
      ":redraw"
    ];
  };

  normal.m.t = {
    a = "@|${blockTag} t<ret>sxxx<ret>c";
    i = "@|${inlineTag} i<ret>sxxx<ret>c";
  };
  select.m.t = {
    a = "@|${blockTag} t<ret>sxxx<ret>c";
    i = "@|${inlineTag} i<ret>sxxx<ret>c";
  };
}
