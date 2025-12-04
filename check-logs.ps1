# Check Backend Logs Script
# This script checks the backend container logs to diagnose errors

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Checking Backend Container Logs" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "This script needs Administrator privileges. Restarting as Administrator..." -ForegroundColor Yellow
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Write-Host "Running with Administrator privileges..." -ForegroundColor Green
Write-Host ""

# Change to project directory
$scriptDir = Split-Path -Parent $PSCommandPath
Set-Location $scriptDir

Write-Host "[1/2] Fetching backend container logs..." -ForegroundColor Yellow
Write-Host ""

# Get backend logs
cmd /c "docker compose logs backend --tail=100"

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "Log check complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press any key to close..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
