from fastapi import APIRouter, Depends
from pydantic import BaseModel
from typing import List

import repos.user as user
from utils.response import CustomResponse

router = APIRouter()

@router.post("/list")
async def list_users_route() -> List[user.User]:
    return await user.list_user()

class DeleteUserRequest(BaseModel):
    user_id: str

@router.post("/delete")
async def delete_user_route(request: DeleteUserRequest) -> CustomResponse:
    await user.delete_user_byid(request.user_id)
    return CustomResponse(detail="User deleted successfully")