from fastapi import APIRouter

from .data.protocols import router as protocols_router
from .user import router as user_router

router = APIRouter()

router.include_router(user_router, prefix="/user", tags=["user"])
router.include_router(protocols_router, prefix="/data", tags=["data"])