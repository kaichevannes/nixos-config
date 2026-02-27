{
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
      name = "javascript";
      formatter.command = "prettier";
      formatter.args = [
        "--parser"
        "javascript"
      ];
      auto-format = true;
    }
    {
      name = "typescript";
      formatter.command = "prettier";
      formatter.args = [
        "--parser"
        "typescript"
      ];
      auto-format = true;
    }
    {
      name = "tsx";
      formatter.command = "prettier";
      formatter.args = [
        "--parser"
        "typescript"
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
}
