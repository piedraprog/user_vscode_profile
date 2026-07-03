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

Write-Host "Restoring Cursor MCP profile..."
Ensure-Directory "$UserHome\.cursor"
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
  "eamodio.gitlens",
  "esbenp.prettier-vscode",
  "mhutchie.git-graph",
  "sldobri.bunker",
  "streetsidesoftware.code-spell-checker",
  "streetsidesoftware.code-spell-checker-spanish",
  "typescriptteam.native-preview",
  "usernamehw.errorlens"
)

foreach ($extension in $extensions) {
  code --install-extension $extension --force
}

Write-Host "Manual step: restore anysphere.remote-ssh from Cursor local extension folder or a VSIX backup."
Write-Host "Manual step: merge codex/codex-mcp.toml into $UserHome\.codex\config.toml."
Write-Host "Manual step: install Codex skills from https://github.com/piedraprog/unified-personal-skills."
Write-Host "Remember to set CMS_API_KEY and STITCH_API_KEY as environment variables."
