{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = true;
      customCommands = [
        {
          key = "C";
          description = "Conventional Commit";
          context = "files";
          command = ''
            git commit -m "{{ .Form.Type }}{{if .Form.Scopes}}({{ .Form.Scopes }}){{end}}{{if .Form.BreakingChange}}!{{end}}: {{ .Form.Description }}" \
            {{- if .Form.LongDescription }}
            -m "{{ .Form.LongDescription }}" \
            {{- end }}
            {{- if .Form.BreakingChange }}
            -m "BREAKING CHANGE: {{ .Form.BreakingChange }}"
            {{- end }}
          '';
          prompts = [
            {
              type = "menu";
              title = "Type of change";
              key = "Type";
              options = [
                {
                  name = "feat";
                  description = "A new feature";
                  value = "feat";
                }
                {
                  name = "fix";
                  description = "A bug fix";
                  value = "fix";
                }
                {
                  name = "refactor";
                  description = "A code change that neither fixes a bug nor adds a feature";
                  value = "refactor";
                }
                {
                  name = "test";
                  description = "Adding missing tests or correcting existing tests";
                  value = "test";
                }
                {
                  name = "docs";
                  description = "Documentation only changes";
                  value = "docs";
                }
                {
                  name = "build";
                  description = "Changes that affect the build system or external dependencies";
                  value = "build";
                }
                {
                  name = "ci";
                  description = "Changes to our CI configuration files and scripts";
                  value = "ci";
                }
                {
                  name = "chore";
                  description = "Other changes that don't modify src or test files";
                  value = "chore";
                }
                {
                  name = "revert";
                  description = "Reverts a previous commit";
                  value = "revert";
                }
                {
                  name = "perf";
                  description = "A code change that improves performance";
                  value = "perf";
                }
                {
                  name = "style";
                  description = "Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)";
                  value = "style";
                }
              ];
            }
            {
              type = "input";
              title = "Enter the scope(s) of this change";
              key = "Scopes";
            }
            {
              type = "input";
              title = "Enter a short description of the change";
              key = "Description";
            }
            {
              type = "input";
              title = "Enter a more detailed description (optional)";
              key = "LongDescription";
            }
            {
              type = "input";
              title = "Describe the breaking change, if any (leave empty if none)";
              key = "BreakingChange";
            }
            {
              type = "confirm";
              title = "Is the commit message correct?";
              body = ''
                {{ .Form.Type }}{{if .Form.Scopes}}({{ .Form.Scopes }}){{end}}{{if .Form.BreakingChange}}!{{end}}: {{ .Form.Description }}
                {{- if .Form.LongDescription }}

                {{ .Form.LongDescription }}
                {{- end }}
                {{- if .Form.BreakingChange }}

                BREAKING CHANGE: {{ .Form.BreakingChange }}
                {{- end }}
              '';
            }
          ];
        }
      ];
    };
  };
}
