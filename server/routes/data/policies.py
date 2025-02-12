from fastapi import APIRouter, HTTPException
from typing import List, Optional
from pydantic import BaseModel

import repos.files as files

router = APIRouter()

@router.post("/privacy/get")
async def get_privacy_policy_route() -> Optional[files.File]:
    return await files.get_file_by_name("privacy policy")

@router.post("/terms/get")
async def get_terms_conditions_route() -> Optional[files.File]:
    return await files.get_file_by_name("terms conditions")