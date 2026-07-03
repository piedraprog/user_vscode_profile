# Coding Profile Backup

Personal coding environment backup for Cursor, VS Code, Codex, and Antigravity.

Last refreshed: 2026-07-03

## VS Code / Cursor Extensions

These are the extensions restored into Cursor and VS Code:

```text
angular.ng-template@22.0.1
anysphere.remote-ssh@1.1.6
anysphere.remote-wsl@1.0.13
astro-build.astro-vscode@2.16.17
bradlc.vscode-tailwindcss@0.14.28/0.14.29
dbaeumer.vscode-eslint@3.0.24
eamodio.gitlens@18.2.0
esbenp.prettier-vscode@12.4.0
franklinteixeira205.primeflex@0.0.2
gruntfuggly.todo-tree@0.0.226
humao.rest-client@0.25.0/0.25.1
johnpapa.vscode-peacock@4.2.2
loczek.next-js-ts-snippets@2.0.3
mhutchie.git-graph@1.30.0
ms-azuretools.vscode-containers@2.4.5
ms-azuretools.vscode-docker@2.0.0
pkief.material-icon-theme@5.36.1
sldobri.bunker@1.1.6
sst-dev.opencode@0.0.13
streetsidesoftware.code-spell-checker@4.5.6
streetsidesoftware.code-spell-checker-spanish@2.3.9
tomoki1207.pdf@1.2.2
typescriptteam.native-preview@0.20260703.1
usernamehw.errorlens@3.26.0/3.28.0
vector-of-bool.gitflow@1.2.1
yigitfindikli.primengsnippets@1.0.5
```

The Anysphere remote extensions are Cursor-specific. Restore them from Cursor's local extension folder or a private VSIX backup. Some less common extensions may also need a VSIX fallback depending on Marketplace availability.

## Cursor Agents And Rules

Recovered Cursor instructions are stored in:

```text
cursor/agents/
cursor/rules/
```

Restore them to:

```text
%USERPROFILE%\.cursor\agents
%USERPROFILE%\.cursor\rules
```

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

Secret values are not committed. `CMS_API_KEY` and `STITCH_API_KEY` must be set as environment variables on each machine. Old local MCP files were intentionally left out because they may contain hardcoded secrets.

## Codex Skills

Codex personal skills source:

```text
https://github.com/piedraprog/unified-personal-skills
```

On the original machine, 1030 unique skills were installed from the personal skills registry. Twelve additional portable skills were recovered from Cursor plugin caches, for 1042 installed Codex skills total.

Recovered portable plugin skills:

```text
gsap-core
gsap-frameworks
gsap-performance
gsap-plugins
gsap-react
gsap-scrolltrigger
gsap-timeline
gsap-utils
stripe-best-practices
stripe-directory
stripe-projects
upgrade-stripe
```

The duplicated skill names skipped during install are recorded in [`codex/skills-backup.json`](codex/skills-backup.json).

## Antigravity

Antigravity did not expose a VS Code-compatible extension CLI or extension directory on this install. The desired extension profile is saved in [`antigravity/cursor-extensions-profile.json`](antigravity/cursor-extensions-profile.json).

The MCP file can be restored to:

```text
C:\Users\<user>\AppData\Roaming\Antigravity\User\mcp.json
C:\Users\<user>\.antigravity\mcp.json
```
