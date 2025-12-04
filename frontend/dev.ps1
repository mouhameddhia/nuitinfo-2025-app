# Frontend Development Helper Script

Write-Host "Frontend Development Helper" -ForegroundColor Cyan
Write-Host "===========================" -ForegroundColor Cyan
Write-Host ""

# Check if in frontend directory
if (-not (Test-Path ".\package.json")) {
    Write-Host "Error: Please run this script from the frontend directory" -ForegroundColor Red
    exit 1
}

# Menu
Write-Host "Select an option:" -ForegroundColor Yellow
Write-Host "1. Install dependencies" -ForegroundColor White
Write-Host "2. Start development server" -ForegroundColor White
Write-Host "3. Build for production" -ForegroundColor White
Write-Host "4. Run tests" -ForegroundColor White
Write-Host "5. Run tests with coverage" -ForegroundColor White
Write-Host "6. Lint code" -ForegroundColor White
Write-Host "7. Fix linting issues" -ForegroundColor White
Write-Host "8. Preview production build" -ForegroundColor White
Write-Host "0. All (setup from scratch)" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter choice"

switch ($choice) {
    "1" {
        Write-Host "Installing dependencies..." -ForegroundColor Yellow
        npm install
        Write-Host "✓ Dependencies installed" -ForegroundColor Green
    }
    "2" {
        Write-Host "Starting development server..." -ForegroundColor Yellow
        Write-Host "Server will be available at http://localhost:5173" -ForegroundColor Green
        npm run dev
    }
    "3" {
        Write-Host "Building for production..." -ForegroundColor Yellow
        npm run build
        Write-Host "✓ Build complete! Output in dist/" -ForegroundColor Green
    }
    "4" {
        Write-Host "Running tests..." -ForegroundColor Yellow
        npm test
    }
    "5" {
        Write-Host "Running tests with coverage..." -ForegroundColor Yellow
        npm run test:coverage
    }
    "6" {
        Write-Host "Linting code..." -ForegroundColor Yellow
        npm run lint
    }
    "7" {
        Write-Host "Fixing linting issues..." -ForegroundColor Yellow
        npm run lint -- --fix
        Write-Host "✓ Linting complete" -ForegroundColor Green
    }
    "8" {
        Write-Host "Starting preview server..." -ForegroundColor Yellow
        npm run preview
    }
    "0" {
        Write-Host "Full setup..." -ForegroundColor Yellow
        Write-Host "[1/2] Installing dependencies..." -ForegroundColor Cyan
        npm install
        Write-Host "[2/2] Setup complete!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Start development with:" -ForegroundColor Yellow
        Write-Host "npm run dev" -ForegroundColor Cyan
    }
    default {
        Write-Host "Invalid choice" -ForegroundColor Red
    }
}
