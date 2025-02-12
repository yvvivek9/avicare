from repos.default import *

COLLECTION_NAME = "protocols"

class ExerciseDataHolder(BaseModel):
    exercise_id: str
    name: str

class Protocol(MongoDbBaseModel):
    name: str
    description: str
    image: str
    exercises: List[str]


async def list_protocols() -> List[Protocol]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    result = clc.find()
    ret_list = []
    for r in result:
        ret_list.append(Protocol(**r))
    return ret_list

async def get_protocol_by_id(uid: str) -> Optional[Protocol]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    res = clc.find_one({"_id": ObjectId(uid)})
    if res:
        return Protocol(**res)
    return None

async def insert_protocol(protocol: Protocol):
    await insert_to_collection(COLLECTION_NAME, protocol)

async def update_protocol(uid: str, protocol: Protocol):
    await update_entry_in_collection_byid(COLLECTION_NAME, uid, protocol)

async def delete_protocol_byid(uid: str):
    await delete_entry_in_collection_byid(COLLECTION_NAME, uid)