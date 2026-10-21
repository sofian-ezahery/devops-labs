from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_main():
    return {"Hello": "World"}

@app.get("/health")
def read_main():
    return {"status": "ok"}
