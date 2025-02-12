from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel

from config.auth import verify_jwt_admin
import repos.protocol as protocol
from utils.response import CustomResponse

router = APIRouter()

@router.post("/add")
async def add_protocol_route(request: protocol.Protocol, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await protocol.insert_protocol(request)
    return CustomResponse(detail="Protocol added successfully")

@router.post("/update")
async def update_protocol_route(request: protocol.Protocol, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await protocol.update_protocol(request.id, request)
    return CustomResponse(detail="Protocol updated successfully")


class DeleteProtocolRequest(BaseModel):
    protocol_id: str

@router.post("/delete")
async def delete_protocol_route(request: DeleteProtocolRequest, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    await protocol.delete_protocol_byid(request.protocol_id)
    return CustomResponse(detail="Protocol deleted successfully")