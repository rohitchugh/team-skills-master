# Team Skills Master - one-line bootstrap installer (Windows)
# Ensures git, clones/updates the repo, then runs the full installer (skills + Python).
$ErrorActionPreference = 'Stop'
$repo = 'https://github.com/rohitchugh/team-skills-master.git'
$dir  = Join-Path $env:USERPROFILE 'team-skills-master'

function Refresh-Path {
  $m = [Environment]::GetEnvironmentVariable('Path','Machine')
  $u = [Environment]::GetEnvironmentVariable('Path','User')
  $env:Path = (@($m,$u) | Where-Object { $_ }) -join ';'
}

Write-Host ""
Write-Host "Team Skills Master - installer" -ForegroundColor Cyan
Write-Host "==============================" -ForegroundColor Cyan

# 1. Ensure git is available (Git for Windows includes the browser sign-in helper).
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host "Installing Git..." -ForegroundColor Yellow
  if (Get-Command winget -ErrorAction SilentlyContinue) {
    winget install --id Git.Git -e --silent --accept-source-agreements --accept-package-agreements | Out-Null
    Refresh-Path
  }
}
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
  Write-Host "ERROR: git is not available. Install Git from https://git-scm.com/download/win then re-run." -ForegroundColor Red
  return
}

# 2. Download. Uses the read-only access token from $env:TSM_TOKEN (set in the
#    install command). Falls back to normal GitHub auth if no token is provided.
$base = 'github.com/rohitchugh/team-skills-master.git'
if ($env:TSM_TOKEN) { $cloneUrl = "https://oauth2:$($env:TSM_TOKEN)@$base" } else { $cloneUrl = "https://$base" }

if (Test-Path $dir) { Remove-Item -Recurse -Force $dir }   # always fetch a clean, latest copy
Write-Host "Downloading the latest skills to $dir ..." -ForegroundColor Cyan
git clone --depth 1 $cloneUrl $dir
if (Test-Path (Join-Path $dir '.git')) {
  git -C $dir remote set-url origin "https://$base"        # strip the token from local config
}
if (-not (Test-Path (Join-Path $dir 'install.ps1'))) {
  Write-Host "ERROR: download failed. Make sure you have access to the private repo." -ForegroundColor Red
  return
}

# 3. Run the installer (copies skills + sets up Python + packages).
& (Join-Path $dir 'install.ps1')
