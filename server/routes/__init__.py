from fastapi import APIRouter

from .data.protocols import router as protocols_router
from .data.policies import router as policies_router
from .user import router as user_router
from .admin import router as admin_router

router = APIRouter()

router.include_router(user_router, prefix="/user", tags=["user"])
router.include_router(protocols_router, prefix="/data", tags=["data"])
router.include_router(policies_router, prefix="/policies", tags=["policies route"])
router.include_router(admin_router, prefix="/admin", tags=["admin routes"])