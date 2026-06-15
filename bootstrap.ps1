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

# 2. Clone or update. A GitHub sign-in window may appear the first time (private repo).
if (Test-Path (Join-Path $dir '.git')) {
  Write-Host "Updating existing copy at $dir ..." -ForegroundColor Cyan
  git -C $dir pull --ff-only
} else {
  Write-Host "Downloading the repo to $dir (sign in to GitHub if a window appears)..." -ForegroundColor Cyan
  git clone $repo $dir
}
if (-not (Test-Path (Join-Path $dir 'install.ps1'))) {
  Write-Host "ERROR: download failed. Make sure you have access to the private repo." -ForegroundColor Red
  return
}

# 3. Run the installer (copies skills + sets up Python + packages).
& (Join-Path $dir 'install.ps1')
