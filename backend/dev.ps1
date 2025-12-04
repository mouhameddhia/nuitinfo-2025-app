# Backend Development Helper Script

Write-Host "Backend Development Helper" -ForegroundColor Cyan
Write-Host "=========================" -ForegroundColor Cyan
Write-Host ""

# Check if in backend directory
if (-not (Test-Path ".\app")) {
    Write-Host "Error: Please run this script from the backend directory" -ForegroundColor Red
    exit 1
}

# Menu
Write-Host "Select an option:" -ForegroundColor Yellow
Write-Host "1. Install dependencies" -ForegroundColor White
Write-Host "2. Create virtual environment" -ForegroundColor White
Write-Host "3. Activate virtual environment" -ForegroundColor White
Write-Host "4. Run migrations" -ForegroundColor White
Write-Host "5. Create new migration" -ForegroundColor White
Write-Host "6. Start development server" -ForegroundColor White
Write-Host "7. Run tests" -ForegroundColor White
Write-Host "8. Format code (black + isort)" -ForegroundColor White
Write-Host "9. Lint code" -ForegroundColor White
Write-Host "0. All (setup from scratch)" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter choice"

switch ($choice) {
    "1" {
        Write-Host "Installing dependencies..." -ForegroundColor Yellow
        pip install -r requirements.txt
    }
    "2" {
        Write-Host "Creating virtual environment..." -ForegroundColor Yellow
        python -m venv venv
        Write-Host "✓ Virtual environment created" -ForegroundColor Green
        Write-Host "Activate with: .\venv\Scripts\Activate.ps1" -ForegroundColor Gray
    }
    "3" {
        Write-Host "Run this command to activate:" -ForegroundColor Yellow
        Write-Host ".\venv\Scripts\Activate.ps1" -ForegroundColor Cyan
    }
    "4" {
        Write-Host "Running migrations..." -ForegroundColor Yellow
        alembic upgrade head
    }
    "5" {
        $message = Read-Host "Migration message"
        Write-Host "Creating migration..." -ForegroundColor Yellow
        alembic revision --autogenerate -m "$message"
    }
    "6" {
        Write-Host "Starting development server..." -ForegroundColor Yellow
        Write-Host "Server will be available at http://localhost:8000" -ForegroundColor Green
        Write-Host "API docs at http://localhost:8000/docs" -ForegroundColor Green
        uvicorn app.main:app --reload
    }
    "7" {
        Write-Host "Running tests..." -ForegroundColor Yellow
        pytest --cov=app --cov-report=term-missing
    }
    "8" {
        Write-Host "Formatting code..." -ForegroundColor Yellow
        black app/
        isort app/
        Write-Host "✓ Code formatted" -ForegroundColor Green
    }
    "9" {
        Write-Host "Linting code..." -ForegroundColor Yellow
        flake8 app/
    }
    "0" {
        Write-Host "Full setup..." -ForegroundColor Yellow
        Write-Host "[1/5] Creating virtual environment..." -ForegroundColor Cyan
        python -m venv venv
        Write-Host "[2/5] Activating virtual environment..." -ForegroundColor Cyan
        & .\venv\Scripts\Activate.ps1
        Write-Host "[3/5] Installing dependencies..." -ForegroundColor Cyan
        pip install -r requirements.txt
        Write-Host "[4/5] Running migrations..." -ForegroundColor Cyan
        alembic upgrade head
        Write-Host "[5/5] Setup complete!" -ForegroundColor Green
        Write-Host ""
        Write-Host "Start server with:" -ForegroundColor Yellow
        Write-Host "uvicorn app.main:app --reload" -ForegroundColor Cyan
    }
    default {
        Write-Host "Invalid choice" -ForegroundColor Red
    }
}
