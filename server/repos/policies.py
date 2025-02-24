from repos.default import *

COLLECTION_NAME = "policies"

class Policy(MongoDbBaseModel):
    name: str
    content: str

async def get_policy_by_name(name: str) -> Optional[Policy]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    res = clc.find_one({"name": name})
    if res:
        return Policy(**res)
    return None

async def insert_policy(policy: Policy):
    await insert_to_collection(COLLECTION_NAME, policy)

async def update_policy(uid: str, policy: Policy):
    await update_entry_in_collection_byid(COLLECTION_NAME, uid, policy)
