import httpserver, std/asyncdispatch, std/os, ws

var serverThread: Thread[void]

proc serverProc() =
  proc handler(request: HttpRequest, response: var HttpResponse) =
    echo request.headers
    echo request.body

  let server = newHttpServer(handler)
  server.serve(Port(8081))

createThread(serverThread, serverProc)

sleep(1000)

var websocket = waitFor newWebSocket("ws://127.0.0.1:8081")
