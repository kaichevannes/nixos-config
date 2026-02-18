{
  normal = {
    C-g = [
      ":write-all"
      ":insert-output lazygit >/dev/tty"
      ":redraw"
      ":reload-all"
    ];
  };
  normal.space = {
    e = [
      ":sh rm -f /tmp/unique-file-helixyazi"
      ":insert-output yazi '%{buffer_name}' --chooser-file=/tmp/unique-file-helixyazi"
      ":insert-output echo \"x1b[?1049h\" > /dev/tty"
      ":open %sh{cat /tmp/unique-file-helixyazi}"
      ":redraw"
    ];
  };
}
