# 🚀 Quick Commands Cheatsheet

## Initial Setup

```powershell
# Run setup script
.\setup.ps1

# OR manually with Docker
docker-compose up -d

# OR manually without Docker
# Backend
cd backend
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
Copy-Item .env.example .env
# Edit .env then:
alembic upgrade head
uvicorn app.main:app --reload

# Frontend (new terminal)
cd frontend
npm install
Copy-Item .env.example .env
npm run dev
```

## Daily Development

### Start Everything
```powershell
# With Docker
docker-compose up -d

# Without Docker
# Terminal 1: Backend
cd backend; .\venv\Scripts\Activate.ps1; uvicorn app.main:app --reload

# Terminal 2: Frontend
cd frontend; npm run dev
```

### Stop Everything
```powershell
# Docker
docker-compose down

# Without Docker
# Ctrl+C in each terminal
```

## Backend Commands

```powershell
cd backend
.\venv\Scripts\Activate.ps1

# Run server
uvicorn app.main:app --reload

# Run tests
pytest
pytest --cov=app
pytest -v -k "test_name"

# Database migrations
alembic revision --autogenerate -m "description"
alembic upgrade head
alembic downgrade -1
alembic history

# Code quality
black app/
isort app/
flake8 app/

# Install package
pip install package-name
pip freeze > requirements.txt
```

## Frontend Commands

```powershell
cd frontend

# Run dev server
npm run dev

# Run tests
npm test
npm run test:coverage
npm run test -- --watch

# Build
npm run build
npm run preview

# Code quality
npm run lint
npm run lint -- --fix

# Install package
npm install package-name
npm install -D package-name  # dev dependency
```

## Docker Commands

```powershell
# Start all services
docker-compose up -d

# Start and rebuild
docker-compose up -d --build

# Stop all
docker-compose down

# Stop and remove volumes (⚠️ deletes database)
docker-compose down -v

# View logs
docker-compose logs -f
docker-compose logs -f backend
docker-compose logs -f frontend

# Restart a service
docker-compose restart backend

# Execute command in container
docker-compose exec backend python --version
docker-compose exec backend alembic upgrade head

# View running containers
docker-compose ps

# Clean up
docker system prune -a
```

## Git Workflow

```powershell
# Setup
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/USER/REPO.git
git push -u origin main

# Daily workflow
git checkout develop
git pull origin develop
git checkout -b feature/my-feature

# Make changes...
git add .
git commit -m "feat: add new feature"
git push origin feature/my-feature

# Update branch with latest develop
git checkout develop
git pull origin develop
git checkout feature/my-feature
git merge develop

# If conflicts:
# Resolve in VS Code
git add .
git commit -m "merge: resolve conflicts"
git push origin feature/my-feature
```

## Database Operations

```powershell
# With Docker
docker-compose exec db psql -U nuitinfo -d nuitinfo_db

# Common SQL commands
\dt              # List tables
\d users         # Describe table
\q               # Quit

# Backup
docker-compose exec db pg_dump -U nuitinfo nuitinfo_db > backup.sql

# Restore
docker-compose exec -T db psql -U nuitinfo nuitinfo_db < backup.sql

# Reset database
docker-compose down -v
docker-compose up -d db
cd backend
alembic upgrade head
```

## API Testing

```powershell
# Open API docs in browser
start http://localhost:8000/docs

# Or use curl/Invoke-WebRequest
Invoke-WebRequest -Uri http://localhost:8000/api/v1/health

# Test registration
$body = @{
    email = "test@example.com"
    username = "testuser"
    password = "testpass123"
} | ConvertTo-Json

Invoke-WebRequest -Uri http://localhost:8000/api/v1/auth/register `
    -Method POST `
    -ContentType "application/json" `
    -Body $body

# Test login
$loginBody = @{
    username = "testuser"
    password = "testpass123"
} | ConvertTo-Json

$response = Invoke-WebRequest -Uri http://localhost:8000/api/v1/auth/login/json `
    -Method POST `
    -ContentType "application/json" `
    -Body $loginBody

$token = ($response.Content | ConvertFrom-Json).access_token

# Use token
Invoke-WebRequest -Uri http://localhost:8000/api/v1/users/me `
    -Headers @{ Authorization = "Bearer $token" }
```

## Troubleshooting

### Port already in use
```powershell
# Find process using port
netstat -ano | findstr :8000
netstat -ano | findstr :5173

# Kill process
taskkill /PID <PID> /F
```

### Module not found (Python)
```powershell
cd backend
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
```

### Module not found (Node)
```powershell
cd frontend
Remove-Item -Recurse -Force node_modules
Remove-Item package-lock.json
npm install
```

### Database connection error
```powershell
# Check if PostgreSQL is running
docker-compose ps db

# Restart database
docker-compose restart db

# Check logs
docker-compose logs db
```

### CORS errors
```powershell
# Check backend/.env has correct CORS_ORIGINS
# Should include: http://localhost:5173

# Restart backend
docker-compose restart backend
```

### Git conflicts
```powershell
# Abort merge
git merge --abort

# Or resolve conflicts in VS Code
# Then:
git add .
git commit -m "merge: resolve conflicts"
```

## VS Code Tasks

Press `Ctrl+Shift+P` and type "Run Task":

- Backend: Install Dependencies
- Backend: Run Server
- Backend: Run Tests
- Backend: Create Migration
- Backend: Run Migrations
- Frontend: Install Dependencies
- Frontend: Run Dev Server
- Frontend: Run Tests
- Frontend: Build
- Docker: Start All
- Docker: Stop All
- Docker: Rebuild
- Start Full Stack (both backend + frontend)

## Useful URLs

After starting the application:

- Frontend: http://localhost:5173
- Backend API: http://localhost:8000
- API Docs (Swagger): http://localhost:8000/docs
- API Docs (ReDoc): http://localhost:8000/redoc
- Health Check: http://localhost:8000/api/v1/health

## Performance Tips

```powershell
# Backend: Profile code
pip install py-spy
py-spy top -- python -m uvicorn app.main:app

# Frontend: Analyze bundle
cd frontend
npm run build
npm install -g vite-bundle-visualizer
npx vite-bundle-visualizer

# Docker: Reduce image size
docker system prune -a
docker-compose build --no-cache
```

## Deployment

### Render (Backend)
```powershell
# Build command:
pip install -r requirements.txt

# Start command:
uvicorn app.main:app --host 0.0.0.0 --port $PORT
```

### Vercel (Frontend)
```powershell
# Install Vercel CLI
npm install -g vercel

# Deploy
cd frontend
vercel

# Set env var
vercel env add VITE_API_URL
```

### Railway
```powershell
# Install Railway CLI
npm install -g @railway/cli

# Login and deploy
railway login
railway init
railway up
```

## Emergency Commands

```powershell
# Complete reset
docker-compose down -v
Remove-Item -Recurse -Force backend\venv
Remove-Item -Recurse -Force frontend\node_modules
.\setup.ps1

# Quick health check
curl http://localhost:8000/api/v1/health
curl http://localhost:5173

# View all processes
Get-Process | Where-Object {$_.ProcessName -like "*python*" -or $_.ProcessName -like "*node*"}

# Kill all Python/Node processes (⚠️ use carefully)
Get-Process python | Stop-Process -Force
Get-Process node | Stop-Process -Force
```

---

💡 **Pro Tip**: Bookmark this file and keep it open during development!
