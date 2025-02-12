from fastapi import APIRouter

from .auth import router as auth_router
from .exercise import router as exercise_router
from .protocols import router as protocols_router
from .user import router as user_router

router = APIRouter()

router.include_router(auth_router, prefix="/auth")
router.include_router(exercise_router, prefix="/exercise")
router.include_router(protocols_router, prefix="/protocol")
router.include_router(user_router, prefix="/user")