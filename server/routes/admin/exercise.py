from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel

from config.auth import verify_jwt_admin
import repos.exercise as exercise
from utils.response import CustomResponse

router = APIRouter()

@router.post("/add")
async def add_exercise_route(request: exercise.Exercise, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await exercise.insert_exercise(request)
    return CustomResponse(detail="Exercise added successfully")

@router.post("/update")
async def update_exercise_route(request: exercise.Exercise, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await exercise.update_exercise(request.id, request)
    return CustomResponse(detail="Exercise updated successfully")


class DeleteExerciseRequest(BaseModel):
    exercise_id: str

@router.post("/delete")
async def delete_exercise_route(request: DeleteExerciseRequest, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await exercise.delete_exercise_byid(request.exercise_id)
    return CustomResponse(detail="Exercise deleted successfully")
