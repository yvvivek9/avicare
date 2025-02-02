from fastapi import Depends, HTTPException, Security
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials, APIKeyHeader
import time
import jwt
import os

JWT_SECRET = os.getenv('JWT_SECRET')
JWT_ALGORITHM = os.getenv('JWT_ALGORITHM')
JWT_VALIDITY = os.getenv('JWT_VALIDITY')  # in seconds

VALID_API_KEYS = {os.getenv('API_KEY')}


async def sign_jwt(user_id: str) -> str:
    payload = {
        "user_id": user_id,
        "expires": time.time() + float(JWT_VALIDITY),
    }
    return jwt.encode(payload, JWT_SECRET, algorithm=JWT_ALGORITHM)


async def verify_jwt(security: HTTPAuthorizationCredentials = Depends(HTTPBearer(scheme_name='Bearer'))) -> str:
    try:
        decoded = jwt.decode(security.credentials, JWT_SECRET, algorithms=[JWT_ALGORITHM])
        if decoded["expires"] >= time.time():
            return decoded["user_id"]
        else:
            raise HTTPException(status_code=401, detail="Authorization expired")
    except Exception as e:
        print(f"Error verifying JWT: {e}")
        raise HTTPException(status_code=401, detail="Invalid authentication")


api_key_header = APIKeyHeader(name="X-API-Key")
def validate_api_key(api_key: str = Security(api_key_header)):
    if api_key not in VALID_API_KEYS:
        raise HTTPException(status_code=403, detail="Missing or invalid API key")