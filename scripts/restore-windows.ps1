param(
  [string]$UserHome = $env:USERPROFILE
)

$ErrorActionPreference = "Stop"
$RepoRoot = Split-Path -Parent $PSScriptRoot

function Ensure-Directory($Path) {
  if (!(Test-Path -LiteralPath $Path)) {
    New-Item -ItemType Directory -Path $Path | Out-Null
  }
}

Write-Host "Restoring Cursor agents and rules..."
Ensure-Directory "$UserHome\.cursor"
Ensure-Directory "$UserHome\.cursor\agents"
Ensure-Directory "$UserHome\.cursor\rules"
Copy-Item "$RepoRoot\cursor\agents\*" "$UserHome\.cursor\agents" -Recurse -Force
Copy-Item "$RepoRoot\cursor\rules\*" "$UserHome\.cursor\rules" -Recurse -Force

Write-Host "Restoring Cursor MCP profile..."
Copy-Item "$RepoRoot\mcp\cursor-compatible-mcp.json" "$UserHome\.cursor\mcp.json" -Force

Write-Host "Restoring Antigravity MCP/profile files..."
Ensure-Directory "$UserHome\AppData\Roaming\Antigravity\User"
Ensure-Directory "$UserHome\.antigravity"
Copy-Item "$RepoRoot\mcp\cursor-compatible-mcp.json" "$UserHome\AppData\Roaming\Antigravity\User\mcp.json" -Force
Copy-Item "$RepoRoot\mcp\cursor-compatible-mcp.json" "$UserHome\.antigravity\mcp.json" -Force
Copy-Item "$RepoRoot\antigravity\cursor-extensions-profile.json" "$UserHome\AppData\Roaming\Antigravity\User\cursor-extensions-profile.json" -Force

Write-Host "Installing VS Code extensions from Marketplace..."
$extensions = @(
  "angular.ng-template",
  "astro-build.astro-vscode",
  "bradlc.vscode-tailwindcss",
  "dbaeumer.vscode-eslint",
  "eamodio.gitlens",
  "esbenp.prettier-vscode",
  "franklinteixeira205.primeflex",
  "gruntfuggly.todo-tree",
  "humao.rest-client",
  "johnpapa.vscode-peacock",
  "loczek.next-js-ts-snippets",
  "mhutchie.git-graph",
  "ms-azuretools.vscode-docker",
  "pkief.material-icon-theme",
  "sldobri.bunker",
  "sst-dev.opencode",
  "streetsidesoftware.code-spell-checker",
  "streetsidesoftware.code-spell-checker-spanish",
  "tomoki1207.pdf",
  "typescriptteam.native-preview",
  "usernamehw.errorlens",
  "vector-of-bool.gitflow",
  "yigitfindikli.primengsnippets"
)

foreach ($extension in $extensions) {
  code --install-extension $extension --force
}

Write-Host "Manual step: restore Cursor-only Anysphere remote extensions from Cursor local files or a private VSIX backup."
Write-Host "Manual step: merge codex/codex-mcp.toml into $UserHome\.codex\config.toml."
Write-Host "Manual step: install Codex skills from https://github.com/piedraprog/unified-personal-skills."
Write-Host "Manual step: install portable plugin skills listed in codex/skills-backup.json if they are missing."
Write-Host "Remember to set CMS_API_KEY and STITCH_API_KEY as environment variables."
