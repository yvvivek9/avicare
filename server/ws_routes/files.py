from fastapi import APIRouter, WebSocket, WebSocketDisconnect

import repos.files as files

ws_router = APIRouter()

@ws_router.websocket("/files/list")
async def list_files_websocket(websocket: WebSocket):
    files_list = await files.list_files()
    await websocket.accept()
    try:
        for file in files_list:
            await websocket.receive_text()
            await websocket.send_json(file.model_dump(by_alias=True))
        await websocket.close()
    except WebSocketDisconnect:
        pass