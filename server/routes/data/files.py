from typing import Optional
from fastapi import APIRouter
from pydantic import BaseModel

import repos.files as files

router = APIRouter()

@router.post("/check")
async def check_file_updates_route() -> str:
    return files.LAST_UPDATED

class GetFileByIDRequest(BaseModel):
    file_id: str

@router.post("/get")
async def get_file_byid_route(request: GetFileByIDRequest) -> Optional[files.File]:
    return await files.get_file_by_id(request.file_id)
