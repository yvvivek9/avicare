from repos.default import *

COLLECTION_NAME = "users"

class User(MongoDbBaseModel):
    name: str
    email: str
    password: Optional[str] = None
    google_id: Optional[str] = None
    apple_id: Optional[str] = None
    mobile: Optional[str] = None
    gender: Optional[str] = None
    dob: Optional[str] = None
    weight: Optional[str] = None
    height: Optional[str] = None
    latitude: Optional[str] = None
    longitude: Optional[str] = None


async def find_user_by_query(query: dict) -> Optional[User]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    # query = {"_id": ObjectId(uid)}
    res = clc.find_one(query)
    if res:
        return User(**res)
    return None

async def list_user() -> List[User]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    result = clc.find()
    ret_list = []
    for r in result:
        ret_list.append(User(**r))
    return ret_list

async def insert_user(user: User):
    await insert_to_collection(COLLECTION_NAME, user)

async def update_user(uid: str, user: User):
    await update_entry_in_collection_byid(COLLECTION_NAME, uid, user)

async def delete_user_byid(uid: str):
    await delete_entry_in_collection_byid(COLLECTION_NAME, uid)