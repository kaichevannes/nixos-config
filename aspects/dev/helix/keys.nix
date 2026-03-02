{ pkgs, ... }:
let
  blockTag = pkgs.writeShellScript "helix_block_tag" ''
    input=$(cat)
    indent=$(printf '%s' "$input" | head -1 | sed 's/[^ \t].*//')
    indentedContent=$(printf '%s' "$input" | sed 's/^/  /')
    printf '%s<xxx>\n%s\n%s</xxx>\n' "$indent" "$indentedContent" "$indent"
  '';
  inlineTag = pkgs.writeShellScript "helix_inline_tag" ''
    IFS= read -r -d ''' input || true;
    indent=$(printf '%s' "$input" | head -1 | sed 's/[^ \t].*//')

    # Only indent if there is more than 1 space. Otherwise we are inside a tag.
    [ ''${#indent} -ge 1 ] && prefix="$indent" || prefix=""
    [[ ''${input: -1:1} == $'\n' ]] && trail=$'\n' || trail=""

    printf '%s<xxx>%s</xxx>%s' "$prefix" "$(echo "$input" | xargs)" "$trail"
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

  select.m.t = {
    a = "@|${blockTag} t<ret>sxxx<ret>c";
    i = "@|${inlineTag} i<ret>sxxx<ret>c";
  };
  normal.m.t = {
    a = "@|${blockTag} t<ret>sxxx<ret>c";
    i = "@|${inlineTag} i<ret>sxxx<ret>c";
  };
}
