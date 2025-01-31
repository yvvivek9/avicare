from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
from dotenv import load_dotenv

from routes import protocols


load_dotenv()

fastAPI = FastAPI()
fastAPI.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

fastAPI.include_router(protocols.router, prefix="/user", tags=["user"])

# @fastAPI.get("/")
# async def index_route():
#     return FileResponse("static/index.html")
# fastAPI.mount("/", StaticFiles(directory="static"), name="flutter")