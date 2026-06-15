#requires -Version 5
# Installs every skill in .\skills into the user's Claude Code skills directory.
# Replaces only this pack's skills; other installed skills (gstack, gitnexus, etc.) are left untouched.
$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$src  = Join-Path $root 'skills'
$dest = Join-Path $env:USERPROFILE '.claude\skills'

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

Write-Host ""
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
Write-Host " DONE. Next steps:" -ForegroundColor Green
Write-Host "   1. Close and reopen Claude Code (skills load at startup)"
Write-Host "   2. Type:  /team-inboxing-mastery   (your starting point)"
Write-Host "   3. Read skills/team-inboxing-mastery/PLAYBOOK.pdf first"
Write-Host "------------------------------------------------------------" -ForegroundColor DarkGray
