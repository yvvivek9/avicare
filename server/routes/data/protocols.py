from fastapi import APIRouter, HTTPException
from typing import List, Optional
from pydantic import BaseModel

import repos.exercise as exercise
import repos.protocol as protocol

router = APIRouter()


@router.post("/protocol/list")
async def list_protocols_route() -> List[protocol.Protocol]:
    return await protocol.list_protocols()


class GetProtocolRequest(BaseModel):
    protocol_id: str

@router.post("/protocol/get")
async def get_protocol_route(request: GetProtocolRequest) -> protocol.Protocol:
    return await protocol.get_protocol_by_id(uid=request.protocol_id)

class GetExerciseRequest(BaseModel):
    exercise_id: str

@router.post("/exercise/get")
async def get_exercise_route(request: GetExerciseRequest) -> exercise.Exercise:
    result = await exercise.find_exercise_by_id(uid=request.exercise_id)
    return result

@router.post("/exercise/list")
async def list_exercise_route() -> List[exercise.Exercise]:
    return await exercise.list_exercise()