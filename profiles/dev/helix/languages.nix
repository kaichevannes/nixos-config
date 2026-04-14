{
  language-server = {
    emmet-lsp = {
      command = "emmet-language-server";
      args = [ "--stdio" ];
    };
    clangd = {
      command = "clangd";
      args = [ "--query-driver=/nix/store/*/bin/clang++" ];
    };
  };

  language = [
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
      name = "html";
      formatter.command = "prettier";
      formatter.args = [
        "--parser"
        "html"
      ];
      auto-format = true;

      language-servers = [
        "vscode-html-language-server"
        "emmet-lsp"
      ];
    }
    {
      name = "javascript";
      formatter.command = "prettier";
      formatter.args = [
        "--parser"
        "typescript"
      ];
      auto-format = true;
    }
    {
      name = "latex";
      formatter.command = "tex-fmt";
      formatter.args = [ "--stdin" ];
      auto-format = true;
    }
    {
      name = "nix";
      formatter.command = "nixfmt";
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

      language-servers = [
        "typescript-language-server"
        "emmet-lsp"
      ];
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
      name = "xml";
      formatter.command = "xmllint";
      formatter.args = [
        "--format"
        "-"
      ];
      auto-format = true;
    }
    {
      name = "yaml";
      formatter.command = "prettier";
      formatter.args = [
        "--parser"
        "yaml"
      ];
      auto-format = true;
    }
  ];
}
