# Rebuild Frontend Container - Run as Administrator
# This script rebuilds the frontend container to install new dependencies

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "This script needs Administrator privileges. Restarting as Administrator..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    exit
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Rebuild Frontend Container" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectPath

Write-Host "Working directory: $projectPath" -ForegroundColor Gray
Write-Host ""

Write-Host "[1/3] Stopping frontend container..." -ForegroundColor Yellow
cmd /c "docker compose stop frontend"
Write-Host "[OK] Frontend stopped" -ForegroundColor Green

Write-Host ""
Write-Host "[2/3] Rebuilding frontend container..." -ForegroundColor Yellow
Write-Host "This will install all dependencies including sonner..." -ForegroundColor Gray
cmd /c "docker compose build frontend --no-cache"

Write-Host ""
Write-Host "[3/3] Starting frontend container..." -ForegroundColor Yellow
cmd /c "docker compose up -d frontend"

Write-Host ""
Write-Host "Waiting for frontend to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Frontend rebuilt successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Access your frontend at:" -ForegroundColor White
Write-Host "  http://localhost:5173" -ForegroundColor Cyan
Write-Host ""
Write-Host "Check logs with: docker compose logs frontend -f" -ForegroundColor Gray
Write-Host ""
Write-Host "Press Enter to close..." -ForegroundColor Gray
Read-Host
