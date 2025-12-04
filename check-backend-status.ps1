# Quick check backend status
Write-Host "Checking backend status..." -ForegroundColor Yellow

$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Elevating to admin..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

$scriptDir = Split-Path -Parent $PSCommandPath
Set-Location $scriptDir

Write-Host "`nContainer Status:" -ForegroundColor Cyan
cmd /c "docker ps -a"

Write-Host "`n`nBackend Logs (last 50 lines):" -ForegroundColor Cyan
cmd /c "docker compose logs backend --tail=50"

Write-Host "`n`nPress any key to close..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
