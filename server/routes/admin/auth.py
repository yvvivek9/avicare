from fastapi import APIRouter

from config.auth import sign_jwt
from utils.response import LoginResponse

router = APIRouter()

@router.post("/login")
async def admin_login_route() -> LoginResponse:
    return LoginResponse(token= await sign_jwt("12345", "admin"))