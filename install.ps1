#requires -Version 5
# Installs every skill in .\skills into the user's Claude Code skills directory,
# then ensures Python + the packages the xlsx skill needs are installed.
# Replaces only this pack's skills; other installed skills (gstack, gitnexus, etc.) are left untouched.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$src  = Join-Path $root 'skills'
$dest = Join-Path $env:USERPROFILE '.claude\skills'

# ---------------------------------------------------------------------------
# 1. Install the skills
# ---------------------------------------------------------------------------
if (-not (Test-Path $src)) { Write-Host "ERROR: skills folder not found next to this script." -ForegroundColor Red; exit 1 }
New-Item -ItemType Directory -Force -Path $dest | Out-Null

Write-Host "Installing Team Skills Master into:" -ForegroundColor Cyan
Write-Host "  $dest" -ForegroundColor Cyan
Write-Host ""

Get-ChildItem -Directory $src | ForEach-Object {
  $target = Join-Path $dest $_.Name
  if (Test-Path $target) { Remove-Item -Recurse -Force $target }
  Copy-Item $_.FullName -Destination $target -Recurse -Force
  Write-Host ("  installed: " + $_.Name) -ForegroundColor Green
}

# ---------------------------------------------------------------------------
# 2. Ensure Python (needed by the xlsx skill scripts)
# ---------------------------------------------------------------------------
Write-Host ""
Write-Host "Checking Python (needed by the xlsx skill)..." -ForegroundColor Cyan

function Refresh-Path {
  $m = [Environment]::GetEnvironmentVariable('Path','Machine')
  $u = [Environment]::GetEnvironmentVariable('Path','User')
  $env:Path = (@($m,$u) | Where-Object { $_ }) -join ';'
}

function Get-PythonCmd {
  foreach ($c in @('py','python','python3')) {
    $cmd = Get-Command $c -ErrorAction SilentlyContinue
    if ($cmd) {
      try {
        $v = & $cmd.Source --version 2>&1
        if ($LASTEXITCODE -eq 0 -and "$v" -match 'Python 3') {
          if ($c -eq 'py') { return @('py','-3') } else { return @($cmd.Source) }
        }
      } catch {}
    }
  }
  return $null
}

$py = Get-PythonCmd
if (-not $py) {
  Write-Host "  Python not found. Installing via winget..." -ForegroundColor Yellow
  $winget = Get-Command winget -ErrorAction SilentlyContinue
  if ($winget) {
    try {
      & winget install --id Python.Python.3.12 -e --silent --accept-source-agreements --accept-package-agreements | Out-Null
    } catch { Write-Host "  winget Python install reported: $($_.Exception.Message)" -ForegroundColor DarkYellow }
    Refresh-Path
    $py = Get-PythonCmd
  }
}

if (-not $py) {
  Write-Host "  Could not auto-install Python." -ForegroundColor Red
  Write-Host "  Install it manually from https://www.python.org/downloads/ (check 'Add to PATH')," -ForegroundColor Red
  Write-Host "  then re-run this installer. (Only the xlsx automation needs Python.)" -ForegroundColor Red
} else {
  $ver = & $py[0] $py[1..($py.Count-1)] --version 2>&1
  Write-Host "  Python ready: $ver" -ForegroundColor Green
  Write-Host "  Installing required packages (openpyxl, pandas, lxml, defusedxml)..." -ForegroundColor Cyan
  $req = Join-Path $root 'requirements.txt'
  try {
    & $py[0] $py[1..($py.Count-1)] -m pip install --upgrade pip --quiet
    if (Test-Path $req) {
      & $py[0] $py[1..($py.Count-1)] -m pip install -r $req --quiet
    } else {
      & $py[0] $py[1..($py.Count-1)] -m pip install openpyxl pandas lxml defusedxml --quiet
    }
    Write-Host "  Python packages installed." -ForegroundColor Green
  } catch {
    Write-Host "  Package install hit an issue: $($_.Exception.Message)" -ForegroundColor DarkYellow
    Write-Host "  You can finish manually: python -m pip install openpyxl pandas lxml defusedxml" -ForegroundColor DarkYellow
  }
}

Write-Host ""
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host " DONE. Next steps:" -ForegroundColor Green
Write-Host "   1. Close and reopen Claude Code (skills load at startup)"
Write-Host "   2. Type:  /team-inboxing-mastery   (your starting point)"
Write-Host "   3. Read skills/team-inboxing-mastery/PLAYBOOK.pdf first"
Write-Host ""
Write-Host " Note: the xlsx skill's formula recalculation (scripts/recalc.py)"
Write-Host " also needs LibreOffice. Optional - get it at libreoffice.org if you"
Write-Host " plan to auto-recalculate spreadsheet formulas."
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
