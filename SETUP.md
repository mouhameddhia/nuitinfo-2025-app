# Quick Setup Commands

## First Time Setup

### 1. Create .env files
```powershell
# Backend
Copy-Item backend\.env.example backend\.env
# Edit backend\.env and update SECRET_KEY and DATABASE_URL

# Frontend
Copy-Item frontend\.env.example frontend\.env
# Edit frontend\.env if needed (default should work)
```

### 2. Option A: Docker Setup (Recommended)
```powershell
docker-compose up --build
```
Access:
- Frontend: http://localhost:5173
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/docs

### 3. Option B: Local Development

#### Backend Setup
```powershell
cd backend
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt

# Create database migrations
alembic revision --autogenerate -m "Initial migration"
alembic upgrade head

# Run server
uvicorn app.main:app --reload
```

#### Frontend Setup (new terminal)
```powershell
cd frontend
npm install
npm run dev
```

## Git Setup

```powershell
# Initialize git (if not already done)
git init
git add .
git commit -m "Initial commit: FastAPI + React project setup"

# Create GitHub repository and push
git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO.git
git branch -M main
git push -u origin main

# Install pre-commit hooks
pip install pre-commit
pre-commit install
```

## Day of Competition

1. **Update .env with any competition-specific configs**
2. **Start development:**
   ```powershell
   docker-compose up -d  # or run backend/frontend separately
   ```
3. **Create feature branch:**
   ```powershell
   git checkout -b feature/competition-topic
   ```
4. **Implement features based on revealed topic**
5. **Test frequently:**
   ```powershell
   # Backend tests
   cd backend; pytest

   # Frontend tests
   cd frontend; npm test
   ```
6. **Deploy early** (see README.md for deployment instructions)

## Useful Development Commands

```powershell
# Database operations
cd backend
.\venv\Scripts\Activate.ps1
alembic revision --autogenerate -m "Description"
alembic upgrade head
alembic downgrade -1

# Create new migration manually
alembic revision -m "Description"

# Install new Python package
pip install package-name
pip freeze > requirements.txt

# Install new npm package
cd frontend
npm install package-name

# Run tests with coverage
cd backend; pytest --cov=app
cd frontend; npm run test:coverage

# Format code
cd backend
black app/
isort app/

cd frontend
npm run lint -- --fix
```

## Troubleshooting

**Backend won't start:**
- Check if PostgreSQL is running
- Verify DATABASE_URL in .env
- Run migrations: `alembic upgrade head`

**Frontend won't start:**
- Delete `node_modules` and `package-lock.json`
- Run `npm install` again
- Check if port 5173 is available

**Database issues:**
- Reset database: `docker-compose down -v`
- Start fresh: `docker-compose up -d db`
- Run migrations: `cd backend; alembic upgrade head`

**CORS errors:**
- Check CORS_ORIGINS in backend/.env includes your frontend URL
- Restart backend server

## Production Checklist

- [ ] Change SECRET_KEY in production
- [ ] Set strong database password
- [ ] Update CORS_ORIGINS to production URLs
- [ ] Set ENVIRONMENT=production
- [ ] Enable HTTPS
- [ ] Set up proper logging
- [ ] Configure rate limiting
- [ ] Set up monitoring
- [ ] Database backups configured
- [ ] Environment variables in deployment platform
