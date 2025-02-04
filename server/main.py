from fastapi import FastAPI, Depends
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse

from dotenv import load_dotenv
load_dotenv()

from config.auth import validate_api_key
from routes import router

fastAPI = FastAPI()
fastAPI.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

fastAPI.include_router(router, dependencies=[Depends(validate_api_key)])

@fastAPI.get("/")
async def index_route():
    return FileResponse("static/index.html")
fastAPI.mount("/", StaticFiles(directory="static"), name="flutter")