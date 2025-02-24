from repos.default import *
import time

COLLECTION_NAME = "files"
LAST_UPDATED = str(time.time())

class File(BaseModel):
    id: Optional[str] = Field(None, alias="_id")
    mime: str
    content: str

    def __init__(self, **data):
        if '_id' in data and isinstance(data['_id'], ObjectId):
            data['_id'] = str(data['_id'])
        super().__init__(**data)


async def list_files() -> List[File]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    result = clc.find()
    ret_list = []
    for r in result:
        ret_list.append(File(**r))
    return ret_list

async def get_file_by_id(uid: str) -> Optional[File]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    res = clc.find_one({"_id": ObjectId(uid)})
    if res:
        return File(**res)
    return None

async def insert_file(file: File):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    value = file.model_dump(by_alias=True)
    value["_id"] = ObjectId(value["_id"])
    clc.insert_one(value)
    global LAST_UPDATED
    LAST_UPDATED = str(time.time())

async def update_file(uid: str, file: File):
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    value = file.model_dump(by_alias=True)
    value.pop('_id')
    clc.update_one(query, {"$set": value})
    global LAST_UPDATED
    LAST_UPDATED = str(time.time())

async def delete_file(uid: str):
    await delete_entry_in_collection_byid(COLLECTION_NAME, uid)
    global LAST_UPDATED
    LAST_UPDATED = str(time.time())