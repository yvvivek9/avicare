from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel

import repos.files as files
from config.auth import verify_jwt_admin
from utils.response import CustomResponse

router = APIRouter()

@router.post("/privacy/update")
async def update_privacy_policy_route(request: files.File, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await files.update_file(request.id, request)
    return CustomResponse(detail="Privacy policy updated successfully")

@router.post("/terms/update")
async def update_terms_conditions_route(request: files.File, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await files.update_file(request.id, request)
    return CustomResponse(detail="Terms Conditions updated successfully")

