from fastapi import APIRouter, HTTPException
from typing import List, Optional
from pydantic import BaseModel

import repos.exercise as exercise
import repos.protocol as protocol

router = APIRouter()


@router.post("/protocol/list")
async def list_protocols_route() -> List[protocol.Protocol]:
    return await protocol.list_protocols()


class GetExerciseRequest(BaseModel):
    exercise_id: str

@router.post("/exercise/get")
async def get_exercise_route(request: GetExerciseRequest) -> exercise.Exercise:
    result = await exercise.find_exercise_by_id(uid=request.exercise_id)
    return result