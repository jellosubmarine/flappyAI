from fastapi import FastAPI, WebSocket
from fastapi.responses import HTMLResponse
import json
import neat_controller

# controller = neat_controller.NEATControl()


app = FastAPI()

html = """
<!DOCTYPE html>
<html>
    <head>
        <title>Chat</title>
    </head>
    <body>
        <h1>Home</h1>
    </body>
</html>
"""


@app.get("/")
async def get():
    return HTMLResponse(html)


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    while True:
        data = await websocket.receive_text()
        data = json.loads(data)
        # print(data)
        await websocket.send_text(str(neat_controller.activate(data["alive"])))