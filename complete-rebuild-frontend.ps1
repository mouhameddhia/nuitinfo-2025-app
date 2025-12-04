# Complete Frontend Rebuild - Run as Administrator
# This script completely rebuilds the frontend with fresh dependencies

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
Write-Host "  Complete Frontend Rebuild" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectPath

Write-Host "Working directory: $projectPath" -ForegroundColor Gray
Write-Host ""

Write-Host "[1/5] Stopping frontend container..." -ForegroundColor Yellow
cmd /c "docker compose stop frontend"
Write-Host "[OK] Frontend stopped" -ForegroundColor Green

Write-Host ""
Write-Host "[2/5] Removing frontend container..." -ForegroundColor Yellow
cmd /c "docker compose rm -f frontend"
Write-Host "[OK] Container removed" -ForegroundColor Green

Write-Host ""
Write-Host "[3/5] Cleaning local node_modules (if exists)..." -ForegroundColor Yellow
if (Test-Path ".\frontend\node_modules") {
    Remove-Item -Recurse -Force ".\frontend\node_modules"
    Write-Host "[OK] Local node_modules removed" -ForegroundColor Green
} else {
    Write-Host "[OK] No local node_modules to clean" -ForegroundColor Green
}

Write-Host ""
Write-Host "[4/5] Rebuilding frontend from scratch..." -ForegroundColor Yellow
Write-Host "This will take 2-3 minutes..." -ForegroundColor Gray
cmd /c "docker compose build frontend --no-cache"

Write-Host ""
Write-Host "[5/5] Starting frontend container..." -ForegroundColor Yellow
cmd /c "docker compose up -d frontend"

Write-Host ""
Write-Host "Waiting for frontend to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

Write-Host ""
Write-Host "Checking if sonner was installed..." -ForegroundColor Yellow
cmd /c "docker compose exec frontend npm list sonner"

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "Frontend rebuilt successfully!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Access your frontend at:" -ForegroundColor White
Write-Host "  http://localhost:5173" -ForegroundColor Cyan
Write-Host ""
Write-Host "If you still see errors, check logs:" -ForegroundColor Yellow
Write-Host "  docker compose logs frontend -f" -ForegroundColor Gray
Write-Host ""
Write-Host "Press Enter to close..." -ForegroundColor Gray
Read-Host
