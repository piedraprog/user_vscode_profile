# Coding Profile Backup

This repository is a public, sanitized backup of a personal coding environment. It is intended to be useful both for a human restoring a workstation and for an AI coding agent that needs to understand what should be configured.

No secrets, tokens, API keys, private SSH keys, cookies, or local credential files should be committed here. Configuration that depends on private values is represented with placeholders such as `${env:CMS_API_KEY}` or `${env:DEV_PROJECTS_DIR}`.

## What This Repository Contains

- VS Code and Cursor extension profile.
- Cursor-compatible MCP server configuration.
- Codex MCP configuration snippet.
- Codex skills source and install notes.
- Antigravity compatibility notes.
- A Windows restore script with safe defaults and manual follow-up steps.

## Repository Layout

```text
.
├── .vscode/extensions.json
├── antigravity/cursor-extensions-profile.json
├── codex/codex-mcp.toml
├── codex/skills-backup.json
├── extensions/vscode-cursor-extensions.json
├── extensions.md
├── mcp/cursor-compatible-mcp.json
└── scripts/restore-windows.ps1
```

## Security Rules For Agents

If an agent updates this repository, follow these rules:

1. Do not commit API keys, GitHub tokens, access tokens, cookies, SSH private keys, `.env` files, or OAuth credentials.
2. Do not commit machine-specific private paths unless they are generic placeholders.
3. Prefer environment variables for anything sensitive or machine-specific.
4. Keep this repository restore-oriented. It should describe how to rebuild the setup, not contain private runtime state.
5. Before committing, scan for obvious secrets:

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
code --install-extension eamodio.gitlens --force
code --install-extension esbenp.prettier-vscode --force
code --install-extension mhutchie.git-graph --force
code --install-extension sldobri.bunker --force
code --install-extension streetsidesoftware.code-spell-checker --force
code --install-extension streetsidesoftware.code-spell-checker-spanish --force
code --install-extension typescriptteam.native-preview --force
code --install-extension usernamehw.errorlens --force
```

The extension `anysphere.remote-ssh` is Cursor-specific and is not available from the VS Code Marketplace. Restore it from a local Cursor installation or a private VSIX backup if needed.

The extension inventory is stored in:

- `extensions/vscode-cursor-extensions.json`
- `.vscode/extensions.json`

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

Restart the target app after changing MCP config.

## Restoring Codex Skills

The personal skills registry is stored separately:

```text
https://github.com/piedraprog/unified-personal-skills
```

The previous install imported 1030 unique skills into Codex. Details and duplicate skill names are recorded in:

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
2. Update MCP config with placeholders only.
3. Update Codex skill source and counts if the skill registry changes.
4. Run a secret scan.
5. Commit and push.
