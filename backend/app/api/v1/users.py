from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel import Session, select
from typing import List
from app.database import get_session
from app.models.models import User
from app.schemas.schemas import UserResponse, UserUpdate
from app.core.deps import get_current_active_user, get_current_superuser
from app.core.security import get_password_hash

router = APIRouter()


@router.get("/me", response_model=UserResponse)
async def read_current_user(current_user: User = Depends(get_current_active_user)):
    """Get current user profile"""
    return current_user


@router.put("/me", response_model=UserResponse)
async def update_current_user(
    user_update: UserUpdate,
    current_user: User = Depends(get_current_active_user),
    session: Session = Depends(get_session)
):
    """Update current user profile"""
    if user_update.email:
        current_user.email = user_update.email
    if user_update.full_name:
        current_user.full_name = user_update.full_name
    if user_update.password:
        current_user.hashed_password = get_password_hash(user_update.password)
    
    session.add(current_user)
    session.commit()
    session.refresh(current_user)
    
    return current_user


@router.get("/", response_model=List[UserResponse])
async def read_users(
    skip: int = 0,
    limit: int = 100,
    current_user: User = Depends(get_current_superuser),
    session: Session = Depends(get_session)
):
    """Get all users (superuser only)"""
    statement = select(User).offset(skip).limit(limit)
    users = session.exec(statement).all()
    return users


@router.get("/{user_id}", response_model=UserResponse)
async def read_user(
    user_id: int,
    current_user: User = Depends(get_current_active_user),
    session: Session = Depends(get_session)
):
    """Get user by ID"""
    statement = select(User).where(User.id == user_id)
    user = session.exec(statement).first()
    
    if not user:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="User not found"
        )
    
    return user
