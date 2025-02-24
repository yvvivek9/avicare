from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel

import repos.policies as policies
from config.auth import verify_jwt_admin
from utils.response import CustomResponse

router = APIRouter()

@router.post("/privacy/update")
async def update_privacy_policy_route(request: policies.Policy, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await policies.update_policy(request.id, request)
    return CustomResponse(detail="Privacy policy updated successfully")

@router.post("/terms/update")
async def update_terms_conditions_route(request: policies.Policy, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await policies.update_policy(request.id, request)
    return CustomResponse(detail="Terms Conditions updated successfully")

