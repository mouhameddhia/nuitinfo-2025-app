# Docker Compose Startup - Run as Administrator
# This script checks for admin rights and elevates if needed

# Check if running as Administrator
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "This script needs Administrator privileges. Restarting as Administrator..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    
    # Restart this script as Administrator
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    exit
}

# Now running as Administrator
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Docker Compose - Administrator Mode   " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set location to script directory
$projectPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectPath
Write-Host "Working directory: $projectPath" -ForegroundColor Gray
Write-Host ""

# Check if docker-compose.yml exists
if (-not (Test-Path ".\docker-compose.yml")) {
    Write-Host "[ERROR] docker-compose.yml not found!" -ForegroundColor Red
    Write-Host "Make sure you're in the correct directory." -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check Docker
Write-Host "[1/3] Checking Docker Desktop..." -ForegroundColor Yellow
try {
    $dockerVersion = docker --version
    Write-Host "[OK] Docker found: $dockerVersion" -ForegroundColor Green
} catch {
    Write-Host "[ERROR] Docker is not running!" -ForegroundColor Red
    Write-Host "Starting Docker Desktop..." -ForegroundColor Yellow
    Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
    Write-Host "Waiting 45 seconds for Docker to start..." -ForegroundColor Yellow
    Start-Sleep -Seconds 45
}

Write-Host ""
Write-Host "[2/3] Building and starting containers..." -ForegroundColor Yellow
Write-Host "This will take 5-10 minutes on first run..." -ForegroundColor Gray
Write-Host ""

# Run docker compose via CMD
$process = Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "docker compose up -d --build" -PassThru -Wait -NoNewWindow
$exitCode = $process.ExitCode

Write-Host ""
Write-Host "Docker command completed with exit code: $exitCode" -ForegroundColor Gray
Write-Host "Waiting for containers to start..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Check if containers were created
$containers = cmd /c "docker compose ps -q" 2>$null
$containerCount = ($containers | Where-Object { $_ -ne "" } | Measure-Object).Count

if ($containerCount -gt 0) {
    Write-Host ""
    Write-Host "[3/3] Checking container status..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    
    docker compose ps
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "SUCCESS! Containers are running!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Access your application at:" -ForegroundColor White
    Write-Host "  Frontend:  http://localhost:5173" -ForegroundColor Cyan
    Write-Host "  Backend:   http://localhost:8000" -ForegroundColor Cyan
    Write-Host "  API Docs:  http://localhost:8000/docs" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Useful commands:" -ForegroundColor Yellow
    Write-Host "  View logs:    docker compose logs -f" -ForegroundColor Gray
    Write-Host "  Stop all:     docker compose down" -ForegroundColor Gray
    Write-Host "  Restart:      docker compose restart" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "[ERROR] Failed to start containers!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Showing error logs:" -ForegroundColor Yellow
    docker compose logs --tail=30
    Write-Host ""
    Write-Host "Try running: docker compose logs -f" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Press Enter to close this window..." -ForegroundColor Gray
Read-Host
