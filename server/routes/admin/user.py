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
    old_user = await user.find_user_by_query({"_id": user.ObjectId(request.user_id)})
    await user.insert_to_collection("deleted_users", old_user)
    await user.delete_user_byid(request.user_id)
    return CustomResponse(detail="User deleted successfully")