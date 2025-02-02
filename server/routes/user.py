from fastapi import APIRouter, HTTPException, Depends
from typing import List, Optional
from pydantic import BaseModel
from bson.objectid import ObjectId

import repos.user as user
from utils.response import LoginResponse, CustomResponse
from config.auth import sign_jwt, verify_jwt

router = APIRouter()


class SignUpEmailRequest(BaseModel):
    name: str
    email: str
    mobile: str
    password: str

@router.post("/signup/email")
async def signup_via_email_route(request: SignUpEmailRequest) -> LoginResponse:
    check = await user.find_user_by_query({"email": request.email})
    if check is not None:
        raise HTTPException(status_code=400, detail="Email already exists")
    await user.insert_user(user.User(
        name=request.name,
        email=request.email,
        mobile=request.mobile,
        password=request.password,
    ))
    new = await user.find_user_by_query({"email": request.email})
    return LoginResponse(token=await sign_jwt(user_id=new.id))

class LoginEmailRequest(BaseModel):
    email: str
    password: str

@router.post("/login/email")
async def login_via_email_route(request: LoginEmailRequest) -> LoginResponse:
    result = await user.find_user_by_query({"email": request.email})
    if result.password == request.password:
        return LoginResponse(token=await sign_jwt(user_id=result.id))
    else:
        raise HTTPException(status_code=400, detail="Invalid credentials")

class LoginGoogleRequest(BaseModel):
    google_id: str
    name: str
    email: str

@router.post("/login/google")
async def login_via_google_route(request: LoginGoogleRequest) -> LoginResponse:
    result = await user.find_user_by_query({"google_id": request.google_id})
    if result is None:
        await user.insert_user(user.User(
            name=request.name,
            email=request.email,
            google_id=request.google_id,
        ))
        result = await user.find_user_by_query({"google_id": request.google_id})

    return LoginResponse(token= await sign_jwt(user_id=result.id))

@router.post("/details/get")
async def get_user_details_route(uid: str = Depends(verify_jwt)) -> user.User:
    return await user.find_user_by_query(query={"_id": ObjectId(uid)})

@router.post("/details/update")
async def update_user_details_route(request: user.User ,uid: str = Depends(verify_jwt)) -> CustomResponse:
    await user.update_user(uid=uid, user=request)
    return CustomResponse(detail="Details updated successful")