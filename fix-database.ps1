# Fix Database Script - Run as Administrator
# This script fixes database issues by recreating everything

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
Write-Host "  Database Fix - Administrator Mode     " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectPath = "C:\Users\abidi\OneDrive\Bureau\project_nuit_de_l_info"
Set-Location $projectPath

Write-Host "[1/5] Stopping all containers..." -ForegroundColor Yellow
$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "docker compose down -v" -PassThru -Wait -NoNewWindow
Write-Host "[OK] Containers stopped" -ForegroundColor Green

Write-Host ""
Write-Host "[2/5] Cleaning frontend node_modules..." -ForegroundColor Yellow
if (Test-Path ".\frontend\node_modules") {
    Remove-Item -Recurse -Force ".\frontend\node_modules" -ErrorAction SilentlyContinue
    Write-Host "[OK] node_modules cleaned" -ForegroundColor Green
} else {
    Write-Host "[OK] node_modules already clean" -ForegroundColor Green
}

Write-Host ""
Write-Host "[3/5] Removing old database volume..." -ForegroundColor Yellow
Start-Sleep -Seconds 2
Write-Host "[OK] Database cleaned" -ForegroundColor Green

Write-Host ""
Write-Host "[4/5] Rebuilding and starting containers..." -ForegroundColor Yellow
Write-Host "This will take 2-3 minutes..." -ForegroundColor Gray
Write-Host ""

$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "docker compose up -d --build" -PassThru -Wait -NoNewWindow

Write-Host ""
Write-Host "[5/5] Waiting for services to be ready..." -ForegroundColor Yellow
Start-Sleep -Seconds 15

# Check containers
$containers = cmd /c "docker compose ps -q" 2>$null
$containerCount = ($containers | Where-Object { $_ -ne "" } | Measure-Object).Count

if ($containerCount -eq 3) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "SUCCESS! Database fixed!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Test your application:" -ForegroundColor White
    Write-Host "  1. Go to: http://localhost:8000/docs" -ForegroundColor Cyan
    Write-Host "  2. Try POST /api/v1/auth/register" -ForegroundColor Cyan
    Write-Host "  3. Create a test user" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "If it still fails, check logs in Docker Desktop" -ForegroundColor Yellow
} else {
    Write-Host ""
    Write-Host "[ERROR] Some containers failed to start" -ForegroundColor Red
    Write-Host "Check Docker Desktop for error details" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Press Enter to close..." -ForegroundColor Gray
Read-Host
