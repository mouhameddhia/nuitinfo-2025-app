# Nuit de l'Info 2025 - Web Application

## 🚀 Quick Start

### Prerequisites
- Python 3.11+
- Node.js 18+
- PostgreSQL 14+
- Docker & Docker Compose (recommended)

### Development Setup

#### Option 1: Docker (Recommended)
```powershell
# Start all services (backend, frontend, database)
docker-compose up --build
```
- Frontend: http://localhost:5173
- Backend API: http://localhost:8000
- API Docs: http://localhost:8000/docs

#### Option 2: Local Development

**Backend:**
```powershell
cd backend
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt
cp .env.example .env
# Edit .env with your database credentials
alembic upgrade head
uvicorn app.main:app --reload
```

**Frontend:**
```powershell
cd frontend
npm install
cp .env.example .env
npm run dev
```

## 📁 Project Structure

```
project_nuit_de_l_info/
├── backend/                 # FastAPI Backend
│   ├── app/
│   │   ├── main.py         # FastAPI application entry
│   │   ├── config.py       # Configuration & environment
│   │   ├── database.py     # Database connection
│   │   ├── models/         # SQLModel database models
│   │   ├── schemas/        # Pydantic schemas (validation)
│   │   ├── api/            # API endpoints
│   │   │   └── v1/
│   │   │       ├── auth.py
│   │   │       ├── users.py
│   │   │       └── ...
│   │   ├── core/           # Core utilities
│   │   │   ├── security.py # JWT, password hashing
│   │   │   └── deps.py     # Dependencies
│   │   └── services/       # Business logic
│   ├── tests/              # Backend tests
│   ├── alembic/            # Database migrations
│   ├── requirements.txt
│   └── Dockerfile
│
├── frontend/               # React + TypeScript + Vite
│   ├── src/
│   │   ├── main.tsx
│   │   ├── App.tsx
│   │   ├── components/     # Reusable components
│   │   ├── pages/          # Page components
│   │   ├── services/       # API client
│   │   ├── hooks/          # Custom React hooks
│   │   ├── store/          # State management (Zustand/Context)
│   │   ├── types/          # TypeScript types
│   │   └── utils/          # Utilities
│   ├── tests/              # Frontend tests
│   ├── package.json
│   ├── tsconfig.json
│   ├── vite.config.ts
│   └── Dockerfile
│
├── infra/                  # Infrastructure & deployment
│   ├── docker-compose.yml
│   └── nginx.conf
│
├── .github/
│   └── workflows/
│       ├── backend-ci.yml
│       └── frontend-ci.yml
│
├── .gitignore
└── README.md
```

## 🛠️ Tech Stack

### Backend
- **FastAPI** - Modern, fast web framework
- **SQLModel** - ORM with Pydantic integration
- **PostgreSQL** - Relational database
- **Alembic** - Database migrations
- **JWT** - Authentication
- **Pydantic** - Data validation
- **pytest** - Testing

### Frontend
- **React 18** - UI library
- **TypeScript** - Type safety
- **Vite** - Build tool
- **React Router** - Routing
- **Axios** - HTTP client
- **Zustand** - State management
- **TailwindCSS** - Styling
- **Vitest** - Testing

## 🔐 Environment Variables

### Backend (.env)
```
DATABASE_URL=postgresql://user:password@localhost:5432/nuitinfo
SECRET_KEY=your-secret-key-here
ALGORITHM=HS256
ACCESS_TOKEN_EXPIRE_MINUTES=30
CORS_ORIGINS=["http://localhost:5173"]
```

### Frontend (.env)
```
VITE_API_URL=http://localhost:8000
```

## 🧪 Testing

### Backend
```powershell
cd backend
pytest
pytest --cov=app tests/
```

### Frontend
```powershell
cd frontend
npm run test
npm run test:coverage
```

## 📦 Deployment

### Backend (Render/Railway/Fly.io)
- Build command: `pip install -r requirements.txt`
- Start command: `uvicorn app.main:app --host 0.0.0.0 --port $PORT`
- Add environment variables in platform dashboard

### Frontend (Vercel/Netlify)
- Framework preset: Vite
- Build command: `npm run build`
- Output directory: `dist`
- Add environment variables in platform dashboard

## 🤝 Git Workflow

1. **Create feature branch:**
   ```powershell
   git checkout -b feature/your-feature-name
   ```

2. **Make changes and commit:**
   ```powershell
   git add .
   git commit -m "feat: description of your feature"
   ```

3. **Push and create Pull Request:**
   ```powershell
   git push origin feature/your-feature-name
   ```

4. **Code review** and merge after CI passes

### Commit Message Convention
- `feat:` new feature
- `fix:` bug fix
- `docs:` documentation
- `style:` formatting
- `refactor:` code restructuring
- `test:` adding tests
- `chore:` maintenance

## 📚 API Documentation

Once backend is running, visit:
- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

## 🎯 Day of Competition Workflow

1. **Receive subject** at sunset
2. **Create feature branch** for main implementation
3. **Divide work** between team members
4. **Implement features** in parallel branches
5. **Frequent commits** and pushes
6. **Code review** quick PRs
7. **Merge regularly** to avoid conflicts
8. **Deploy early** and test online
9. **Submit before sunrise** ☀️

## 📞 Useful Commands

```powershell
# Reset database
docker-compose down -v
docker-compose up -d db
cd backend
alembic upgrade head

# View logs
docker-compose logs -f backend
docker-compose logs -f frontend

# Install new Python package
cd backend
.\venv\Scripts\Activate.ps1
pip install package-name
pip freeze > requirements.txt

# Install new npm package
cd frontend
npm install package-name
```

## 🐛 Troubleshooting

**Port already in use:**
```powershell
# Find process using port
netstat -ano | findstr :8000
# Kill process by PID
taskkill /PID <pid> /F
```

**Database connection error:**
- Check PostgreSQL is running
- Verify DATABASE_URL in .env
- Check firewall settings

**CORS errors:**
- Add frontend URL to CORS_ORIGINS in backend .env
- Restart backend server

## 🏆 Good Luck!

Remember:
- ✅ Commit often
- ✅ Test as you go
- ✅ Keep communication open
- ✅ Stay hydrated & have fun!
