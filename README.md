# Coding Profile Backup

This repository is a public, sanitized backup of a personal coding environment. It is intended to be useful both for a human restoring a workstation and for an AI coding agent that needs to understand what should be configured.

No secrets, tokens, API keys, private SSH keys, cookies, or local credential files should be committed here. Configuration that depends on private values is represented with placeholders such as `${env:CMS_API_KEY}` or `${env:DEV_PROJECTS_DIR}`.

## What This Repository Contains

- VS Code and Cursor extension profile.
- Cursor agents and project rules.
- Cursor-compatible MCP server configuration using placeholders only.
- Codex MCP configuration snippet.
- Codex skills source, install counts, and portable plugin skills.
- Antigravity compatibility notes.
- A Windows restore script with safe defaults and manual follow-up steps.

## Repository Layout

```text
.
|-- .vscode/extensions.json
|-- antigravity/cursor-extensions-profile.json
|-- codex/codex-mcp.toml
|-- codex/skills-backup.json
|-- cursor/agents/
|-- cursor/rules/
|-- extensions/vscode-cursor-extensions.json
|-- extensions.md
|-- mcp/cursor-compatible-mcp.json
`-- scripts/restore-windows.ps1
```

## Security Rules For Agents

If an agent updates this repository, follow these rules:

1. Do not commit API keys, GitHub tokens, access tokens, cookies, SSH private keys, `.env` files, or OAuth credentials.
2. Do not commit machine-specific private paths unless they are generic placeholders.
3. Prefer environment variables for anything sensitive or machine-specific.
4. Keep this repository restore-oriented. It should describe how to rebuild the setup, not contain private runtime state.
5. Do not import old MCP files directly from local editor profiles. They may contain hardcoded secrets.
6. Before committing, scan for obvious secrets:

```powershell
rg -n "gho_|ghp_|github_pat|api[_-]?key|token|secret|password|PRIVATE KEY|C:\\Users" .
```

Expected findings should only be placeholder names, not real values.

## Required Tools On A New Windows Machine

Install these before restoring:

- Git
- GitHub CLI
- VS Code
- Cursor, if desired
- Codex, if desired
- Antigravity, if desired
- Bun, for MCP servers using `bun` or `bunx`
- Python or `uv`, for MCP servers using `uvx`

After installing GitHub CLI, authenticate once for the Windows user:

```powershell
gh auth login
gh auth setup-git
```

The GitHub login is global for that Windows user. Agents running under the same user can reuse it.

## Environment Variables To Recreate Locally

The MCP profile uses placeholders. Define these on the target machine before starting Cursor, Codex, or Antigravity:

```powershell
[Environment]::SetEnvironmentVariable("DEV_PROJECTS_DIR", "C:\Path\To\Development\personal", "User")
[Environment]::SetEnvironmentVariable("OBSIDIAN_VAULT_DIR", "C:\Path\To\ObsidianVault", "User")
[Environment]::SetEnvironmentVariable("OBSIDIAN_BUSINESS_VAULT_DIR", "C:\Path\To\BusinessVault", "User")
[Environment]::SetEnvironmentVariable("DEV_TOOLS_DIR", "C:\Path\To\Development\personal\tools", "User")
[Environment]::SetEnvironmentVariable("CMS_MCP_ENTRY", "C:\Path\To\mcp-cms\dist\index.js", "User")
[Environment]::SetEnvironmentVariable("CMS_URL", "https://example.com", "User")
[Environment]::SetEnvironmentVariable("CMS_API_KEY", "replace-with-local-secret", "User")
[Environment]::SetEnvironmentVariable("STITCH_API_KEY", "replace-with-local-secret", "User")
```

Do not replace these placeholders inside this public repository with real secrets.

## Restoring VS Code Extensions

Most extensions can be installed from the Marketplace:

```powershell
code --install-extension angular.ng-template --force
code --install-extension astro-build.astro-vscode --force
code --install-extension bradlc.vscode-tailwindcss --force
code --install-extension dbaeumer.vscode-eslint --force
code --install-extension eamodio.gitlens --force
code --install-extension esbenp.prettier-vscode --force
code --install-extension franklinteixeira205.primeflex --force
code --install-extension gruntfuggly.todo-tree --force
code --install-extension humao.rest-client --force
code --install-extension johnpapa.vscode-peacock --force
code --install-extension loczek.next-js-ts-snippets --force
code --install-extension mhutchie.git-graph --force
code --install-extension ms-azuretools.vscode-docker --force
code --install-extension pkief.material-icon-theme --force
code --install-extension sldobri.bunker --force
code --install-extension sst-dev.opencode --force
code --install-extension streetsidesoftware.code-spell-checker --force
code --install-extension streetsidesoftware.code-spell-checker-spanish --force
code --install-extension tomoki1207.pdf --force
code --install-extension typescriptteam.native-preview --force
code --install-extension usernamehw.errorlens --force
code --install-extension vector-of-bool.gitflow --force
code --install-extension yigitfindikli.primengsnippets --force
```

The Anysphere remote extensions are Cursor-specific and should be restored from a local Cursor installation or private VSIX backup if needed. Some less common extensions may also need a VSIX fallback depending on Marketplace availability.

The extension inventory is stored in:

- `extensions/vscode-cursor-extensions.json`
- `.vscode/extensions.json`

## Restoring Cursor Agents And Rules

Cursor agents and rules are stored in:

```text
cursor/agents/
cursor/rules/
```

Typical restore locations:

```text
%USERPROFILE%\.cursor\agents
%USERPROFILE%\.cursor\rules
```

These files are text instructions only. They should not contain runtime secrets or local credentials.

## Restoring MCP Servers

The generic Cursor-style MCP file is:

```text
mcp/cursor-compatible-mcp.json
```

Typical restore locations:

```text
%USERPROFILE%\.cursor\mcp.json
%APPDATA%\Antigravity\User\mcp.json
%USERPROFILE%\.antigravity\mcp.json
```

Codex uses TOML rather than Cursor's JSON format. Merge this file into `%USERPROFILE%\.codex\config.toml`:

```text
codex/codex-mcp.toml
```

Restart the target app after changing MCP config. Old local MCP files were intentionally not copied into this repository because they can contain hardcoded connection secrets.

## Restoring Codex Skills

The personal skills registry is stored separately:

```text
https://github.com/piedraprog/unified-personal-skills
```

The previous install imported 1030 unique skills from that registry into Codex. Twelve additional portable skills were recovered from Cursor plugin caches, bringing the installed total to 1042.

The recovered plugin skills are GSAP and Stripe related. The Cursor `continual-learning` plugin skill was skipped because it depends on Cursor-specific agent behavior and is not useful as a standalone Codex skill.

Details and duplicate skill names are recorded in:

```text
codex/skills-backup.json
```

After installing skills, restart Codex so it can discover them.

## Antigravity Notes

This machine's Antigravity installation did not expose a VS Code-compatible extension CLI or extension directory. The desired extension profile is documented in:

```text
antigravity/cursor-extensions-profile.json
```

MCP configuration can still be restored using the JSON file in `mcp/`.

## Windows Restore Script

The script below restores the safe, file-based parts of the profile:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\restore-windows.ps1
```

The script does not write secrets. You still need to set environment variables and manually handle Cursor-only extensions.

## Maintenance Checklist

When updating this profile:

1. Refresh extension lists.
2. Update Cursor agents and rules if they changed.
3. Update MCP config with placeholders only.
4. Update Codex skill source and counts if the skill registry changes.
5. Run a secret scan.
6. Commit and push.
