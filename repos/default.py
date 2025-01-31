from pydantic import BaseModel, Field
from typing import List, Optional
from bson.objectid import ObjectId

from config.database import get_database


class MongoDbBaseModel(BaseModel):
    id: Optional[str] = Field(None, alias="_id")

    def __init__(self, **data):
        if '_id' in data and isinstance(data['_id'], ObjectId):
            data['_id'] = str(data['_id'])
        super().__init__(**data)


async def insert_to_collection(collection: str, entry: MongoDbBaseModel):
    db = await get_database()
    clc = db[collection]
    value = entry.model_dump(by_alias=True)
    value.pop("_id")
    clc.insert_one(value)


async def update_entry_in_collection_byid(collection: str ,uid: str, entry: MongoDbBaseModel):
    db = await get_database()
    clc = db[collection]
    query = {"_id": ObjectId(uid)}
    value = entry.model_dump(by_alias=True)
    value.pop('_id')
    clc.update_one(query, {"$set": value})


async def delete_entry_in_collection_byid(collection: str ,uid: str):
    db = await get_database()
    clc = db[collection]
    query = {"_id": ObjectId(uid)}
    clc.delete_one(query)
