from fastapi import FastAPI, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse
import json
import neat_controller
from threading import Thread

controller = neat_controller.NEATControl()
neat_thread = Thread(target=controller.start)
neat_thread.start()

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
    try:
      while True:
          data = await websocket.receive_text()
          data = json.loads(data)
          controller.x_distance = data["dist_x"]
          controller.alive_vector = data["alive"]
          controller.top_distances = data["dist_top"]
          controller.bot_distances = data["dist_bot"]
          controller.new_data = True
          while (not controller.data_ready):
            continue
          controller.data_ready = False
          await websocket.send_text(str(controller.output_vector))
    except WebSocketDisconnect:
      print("Gen change")