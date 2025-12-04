"""Global error handling middleware"""
import logging
from fastapi import Request, status
from fastapi.responses import JSONResponse
from sqlalchemy.exc import SQLAlchemyError
from pydantic import ValidationError

logger = logging.getLogger("api")


async def global_exception_handler(request: Request, exc: Exception):
    """Handle all uncaught exceptions globally"""
    
    # Database errors
    if isinstance(exc, SQLAlchemyError):
        logger.error(f"Database error: {str(exc)}")
        return JSONResponse(
            status_code=status.HTTP_503_SERVICE_UNAVAILABLE,
            content={
                "error": "Database Error",
                "message": "A database error occurred. Please try again later.",
                "type": "database_error"
            }
        )
    
    # Validation errors
    if isinstance(exc, ValidationError):
        logger.error(f"Validation error: {str(exc)}")
        return JSONResponse(
            status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
            content={
                "error": "Validation Error",
                "message": "Invalid data provided.",
                "details": exc.errors(),
                "type": "validation_error"
            }
        )
    
    # Generic errors
    logger.error(f"Unhandled exception: {type(exc).__name__}: {str(exc)}", exc_info=True)
    return JSONResponse(
        status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
        content={
            "error": "Internal Server Error",
            "message": "An unexpected error occurred. Our team has been notified.",
            "type": "internal_error"
        }
    )
