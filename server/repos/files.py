from repos.default import *

COLLECTION_NAME = "files"

class File(MongoDbBaseModel):
    name: str
    mime: str
    content: str


async def get_file_by_name(name: str) -> Optional[File]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    res = clc.find_one({"name": name})
    if res:
        return File(**res)
    return None

async def insert_file(file: File):
    await insert_to_collection(COLLECTION_NAME, file)

async def update_file(uid: str, file: File):
    await update_entry_in_collection_byid(COLLECTION_NAME, uid, file)

async def delete_file(uid: str):
    await delete_entry_in_collection_byid(COLLECTION_NAME, uid)