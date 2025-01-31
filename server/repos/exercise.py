from repos.default import *

COLLECTION_NAME = "exercise"

class ExerciseStep(BaseModel):
    title: str
    detail: str

class Exercise(MongoDbBaseModel):
    name: str
    description: str
    youtube: str
    steps: List[ExerciseStep]


async def find_exercise_by_id(uid: str) -> Optional[Exercise]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    query = {"_id": ObjectId(uid)}
    res = clc.find_one(query)
    if res:
        return Exercise(**res)
    return None

async def list_exercise() -> List[Exercise]:
    db = await get_database()
    clc = db[COLLECTION_NAME]
    result = clc.find()
    ret_list = []
    for r in result:
        ret_list.append(Exercise(**r))
    return ret_list

async def insert_exercise(exercise: Exercise):
    await insert_to_collection(COLLECTION_NAME, exercise)

async def update_exercise(uid: str, exercise: Exercise):
    await update_entry_in_collection_byid(COLLECTION_NAME, uid, exercise)

async def delete_exercise_byid(uid: str):
    await delete_entry_in_collection_byid(COLLECTION_NAME, uid)