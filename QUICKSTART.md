# ⚡ 5-Minute Quickstart Guide

## Prerequisites Check

✅ **Required:**
- Git installed
- Docker Desktop installed (OR Python 3.11+ AND Node.js 18+ AND PostgreSQL 14+)

## Option 1: Docker Setup (Recommended) ⭐

**Total time: ~5 minutes**

```powershell
# 1. Clone/Navigate to project (you're already here!)
cd c:\Users\abidi\OneDrive\Bureau\project_nuit_de_l_info

# 2. Run setup script
.\setup.ps1
# Choose option 1 (Docker)

# 3. Done! 🎉
```

**Access:**
- Frontend: http://localhost:5173
- Backend: http://localhost:8000
- API Docs: http://localhost:8000/docs

**Test it:**
1. Open http://localhost:5173
2. Click "Register"
3. Create account
4. Login
5. See dashboard

## Option 2: Local Setup

**Total time: ~10 minutes**

### Step 1: Backend (5 min)
```powershell
cd backend

# Create environment
python -m venv venv
.\venv\Scripts\Activate.ps1

# Install dependencies
pip install -r requirements.txt

# Setup .env
Copy-Item .env.example .env
# ⚠️ Edit .env: Change SECRET_KEY and DATABASE_URL

# Run migrations (if PostgreSQL running)
alembic upgrade head

# Start server
uvicorn app.main:app --reload
```

### Step 2: Frontend (5 min)
**Open NEW terminal:**
```powershell
cd frontend

# Install dependencies
npm install

# Setup .env
Copy-Item .env.example .env

# Start dev server
npm run dev
```

**Access:**
- Frontend: http://localhost:5173
- Backend: http://localhost:8000

## First API Test

```powershell
# Health check
Invoke-WebRequest -Uri http://localhost:8000/api/v1/health

# Or just open in browser:
# http://localhost:8000/docs
```

## What's Included? ✨

✅ **Backend (FastAPI + Python)**
- JWT Authentication
- User registration/login
- PostgreSQL database
- Alembic migrations
- API documentation (Swagger)
- Tests (pytest)

✅ **Frontend (React + TypeScript + Vite)**
- Modern React 18
- TypeScript for safety
- Authentication flow
- Protected routes
- State management (Zustand)
- Responsive design

✅ **DevOps**
- Docker Compose setup
- GitHub Actions CI/CD
- Pre-commit hooks
- Linting & formatting

## Next Steps

### 1. Create a test user
```powershell
# Via API docs: http://localhost:8000/docs
# Or via frontend: http://localhost:5173/register
```

### 2. Explore the code structure
```
backend/app/
  ├── api/v1/       <- Add your endpoints here
  ├── models/       <- Database models
  ├── schemas/      <- Request/response schemas
  └── core/         <- Auth & security

frontend/src/
  ├── pages/        <- Add your pages here
  ├── components/   <- Reusable components
  ├── services/     <- API calls
  └── store/        <- State management
```

### 3. Add your first feature

**Backend:**
```python
# backend/app/api/v1/myfeature.py
from fastapi import APIRouter

router = APIRouter()

@router.get("/myendpoint")
async def my_endpoint():
    return {"message": "Hello from my feature!"}

# backend/app/main.py - Add:
from app.api.v1 import myfeature
app.include_router(myfeature.router, prefix="/api/v1", tags=["MyFeature"])
```

**Frontend:**
```typescript
// frontend/src/pages/MyPage.tsx
function MyPage() {
  return <div><h1>My New Page</h1></div>
}
export default MyPage

// frontend/src/App.tsx - Add route:
<Route path="mypage" element={<MyPage />} />
```

### 4. Test your changes
```powershell
# Backend tests
cd backend
pytest

# Frontend tests
cd frontend
npm test
```

### 5. Commit your work
```powershell
git add .
git commit -m "feat: add my feature"
git push
```

## Common Issues & Quick Fixes

### "Port 8000 already in use"
```powershell
netstat -ano | findstr :8000
taskkill /PID <PID> /F
```

### "Module not found"
```powershell
# Backend
cd backend; .\venv\Scripts\Activate.ps1; pip install -r requirements.txt

# Frontend
cd frontend; npm install
```

### "Database connection failed"
```powershell
# With Docker
docker-compose restart db

# Check Docker is running
docker ps
```

### "CORS error"
Make sure `backend/.env` has:
```
CORS_ORIGINS=["http://localhost:5173"]
```
Then restart: `docker-compose restart backend`

## Help & Documentation

📖 **Full documentation:**
- `README.md` - Complete project overview
- `SETUP.md` - Detailed setup instructions
- `COMMANDS.md` - All commands reference
- `BATTLE_PLAN.md` - Competition strategy
- `CONTRIBUTING.md` - Team workflow

🆘 **Need help?**
1. Check the error message
2. Search in documentation files
3. Check Docker logs: `docker-compose logs -f`
4. Ask your teammate!

## Ready for Competition? 🏆

On competition day:
1. Pull latest code: `git pull`
2. Start services: `docker-compose up -d`
3. Read the subject carefully
4. Plan features (use BATTLE_PLAN.md)
5. Create feature branch: `git checkout -b feature/subject-name`
6. Start coding!
7. Commit often, deploy early
8. Have fun! 🎉

---

**🚀 You're all set! Happy coding!**

Not working? Check `README.md` for detailed troubleshooting.
