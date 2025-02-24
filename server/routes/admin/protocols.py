from fastapi import APIRouter, HTTPException, Depends
from pydantic import BaseModel

from config.auth import verify_jwt_admin
import repos.protocol as protocol
import repos.files as files
from utils.response import CustomResponse

router = APIRouter()

@router.post("/add")
async def add_protocol_route(request: protocol.Protocol, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    image_id = str(files.ObjectId())
    image = files.File(_id=image_id, mime="image/png", content=request.image)
    await files.insert_file(image)
    request.image = image_id
    await protocol.insert_protocol(request)
    return CustomResponse(detail="Protocol added successfully")

@router.post("/update")
async def update_protocol_route(request: protocol.Protocol, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    old_protocol = await protocol.get_protocol_by_id(request.id)
    image = await files.get_file_by_id(old_protocol.image)
    if image.content != request.image:
        image.content = request.image
        await files.update_file(image.id, image)
    request.image = old_protocol.image
    await protocol.update_protocol(request.id, request)
    return CustomResponse(detail="Protocol updated successfully")


class DeleteProtocolRequest(BaseModel):
    protocol_id: str

@router.post("/delete")
async def delete_protocol_route(request: DeleteProtocolRequest, uid=Depends(verify_jwt_admin)) -> CustomResponse:
    old_protocol = await protocol.get_protocol_by_id(request.protocol_id)
    await files.delete_file(old_protocol.image)
    await protocol.delete_protocol_byid(request.protocol_id)
    return CustomResponse(detail="Protocol deleted successfully")