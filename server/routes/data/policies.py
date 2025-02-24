from fastapi import APIRouter, HTTPException
from typing import List, Optional
from pydantic import BaseModel

import repos.policies as policies

router = APIRouter()

@router.post("/privacy/get")
async def get_privacy_policy_route() -> Optional[policies.Policy]:
    return await policies.get_policy_by_name("privacy")

@router.post("/terms/get")
async def get_terms_conditions_route() -> Optional[policies.Policy]:
    return await policies.get_policy_by_name("terms")