from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel

from config.auth import verify_jwt_admin
import repos.exercise as exercise
import repos.protocol as protocol
import repos.files as files
from utils.response import CustomResponse

router = APIRouter()

@router.post("/add")
async def add_exercise_route(request: exercise.Exercise, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    image_id = str(files.ObjectId())
    image = files.File(_id=image_id, mime="image/png", content=request.image)
    await files.insert_file(image)
    request.image = image_id
    await exercise.insert_exercise(request)
    return CustomResponse(detail="Exercise added successfully")

@router.post("/update")
async def update_exercise_route(request: exercise.Exercise, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    old_exercise = await exercise.find_exercise_by_id(request.id)
    image = await files.get_file_by_id(old_exercise.image)
    if image.content != request.image:
        image.content = request.image
        await files.update_file(image.id, image)
    request.image = old_exercise.image
    await exercise.update_exercise(request.id, request)
    return CustomResponse(detail="Exercise updated successfully")


class DeleteExerciseRequest(BaseModel):
    exercise_id: str

@router.post("/delete")
async def delete_exercise_route(request: DeleteExerciseRequest, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    protocols = await protocol.list_protocols()
    for p in protocols:
        if request.exercise_id in p.exercises:
            p.exercises.remove(request.exercise_id)
            await protocol.update_protocol(p.id, p)

    old_exercise = await exercise.find_exercise_by_id(request.exercise_id)
    await files.delete_file(old_exercise.image)
    await exercise.delete_exercise_byid(request.exercise_id)
    return CustomResponse(detail="Exercise deleted successfully")
