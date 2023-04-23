from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import os
from typing import Dict
import openai


app = FastAPI()

class Coordinates(BaseModel):
    id: int
    latitude: float
    longitude: float

coordinates_db: Dict[int, Coordinates] = {}

@app.post("/coordinates")
def create_coordinates(coordinate: Coordinates):
    if coordinate.id in coordinates_db:
        raise HTTPException(status_code=400, detail="ID already exists")
    coordinates_db[coordinate.id] = coordinate
    return coordinate

@app.get("/coordinates/{coordinate_id}")
def read_coordinates(coordinate_id: int):
    if coordinate_id not in coordinates_db:
        raise HTTPException(status_code=404, detail="ID not found")
    return coordinates_db[coordinate_id]

@app.put("/coordinates/{coordinate_id}")
def update_coordinates(coordinate_id: int, coordinate: Coordinates):
    if coordinate_id not in coordinates_db:
        raise HTTPException(status_code=404, detail="ID not found")
    coordinates_db[coordinate_id] = coordinate
    return coordinate

@app.delete("/coordinates/{coordinate_id}")
def delete_coordinates(coordinate_id: int):
    if coordinate_id not in coordinates_db:
        raise HTTPException(status_code=404, detail="ID not found")
    del coordinates_db[coordinate_id]
    return {"message": "Coordinate deleted"}

@app.get("openai/{question_id}")
def openai_question(question_id: str):
    openai.api_key = os.getenv("")
    completion = openai.ChatCompletion.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "user", "content": question_id}
    ]
    )
    return completion.choices[0].message