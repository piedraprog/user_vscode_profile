# Coding Profile Backup

Personal coding environment backup for Cursor, VS Code, Codex, and Antigravity.

Last refreshed: 2026-07-03

## VS Code / Cursor Extensions

These are the extensions currently mirrored from Cursor into VS Code:

```text
angular.ng-template@22.0.1
anysphere.remote-ssh@1.1.6
astro-build.astro-vscode@2.16.17
eamodio.gitlens@18.2.0
esbenp.prettier-vscode@12.4.0
mhutchie.git-graph@1.30.0
sldobri.bunker@1.1.6
streetsidesoftware.code-spell-checker@4.5.6
streetsidesoftware.code-spell-checker-spanish@2.3.9
typescriptteam.native-preview@0.20260703.1
usernamehw.errorlens@3.28.0
```

`anysphere.remote-ssh` is a Cursor/Anysphere extension and is not available from the VS Code Marketplace. Restore it from Cursor's local extension folder or package it as a VSIX.

## MCP Servers

The shared MCP profile lives in [`mcp/cursor-compatible-mcp.json`](mcp/cursor-compatible-mcp.json).

Configured servers:

```text
context7
fetch
fs-projects
cms
stitch
```

Secret values are not committed. `CMS_API_KEY` and `STITCH_API_KEY` must be set as environment variables on each machine.

## Codex Skills

Codex personal skills source:

```text
https://github.com/piedraprog/unified-personal-skills
```

On this machine, 1030 unique skills were installed into:

```text
C:\Users\gordo\.codex\skills
```

The duplicated skill names skipped during install are recorded in [`codex/skills-backup.json`](codex/skills-backup.json).

## Antigravity

Antigravity did not expose a VS Code-compatible extension CLI or extension directory on this install. The desired extension profile is saved in [`antigravity/cursor-extensions-profile.json`](antigravity/cursor-extensions-profile.json).

The MCP file can be restored to:

```text
C:\Users\<user>\AppData\Roaming\Antigravity\User\mcp.json
C:\Users\<user>\.antigravity\mcp.json
```
