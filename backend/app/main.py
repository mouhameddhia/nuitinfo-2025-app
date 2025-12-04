from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.config import settings
from app.api.v1 import auth, users, health
from app.database import create_db_and_tables

app = FastAPI(
    title="Nuit de l''Info API",
    description="API for Nuit de l''Info 2025 Web Application",
    version="1.0.0",
    docs_url="/docs",
    redoc_url="/redoc"
)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.CORS_ORIGINS,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include routers
app.include_router(health.router, prefix="/api/v1", tags=["Health"])
app.include_router(auth.router, prefix="/api/v1/auth", tags=["Authentication"])
app.include_router(users.router, prefix="/api/v1/users", tags=["Users"])


@app.get("/")
async def root():
    """Root endpoint - API information"""
    return {
        "message": "Nuit de l''Info 2025 API",
        "version": "1.0.0",
        "docs": "/docs",
        "health": "/api/v1/health"
    }


@app.on_event("startup")
async def startup_event():
    """Initialize services on startup"""
    print(" Application starting up...")
    print(" Creating database tables...")
    create_db_and_tables()
    print(" Database tables created successfully!")


@app.on_event("shutdown")
async def shutdown_event():
    """Clean up on shutdown"""
    print(" Application shutting down...")
    # Add any cleanup logic here
