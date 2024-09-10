from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl

# Define server address and port
server_address = ('', 4443)

# Create an HTTP server
httpd = HTTPServer(server_address, SimpleHTTPRequestHandler)

# Wrap the server socket with SSL
httpd.socket = ssl.wrap_socket(
    httpd.socket,
    keyfile="/home/myuser/certs/server.key",
    certfile="/home/myuser/certs/server.crt",
    server_side=True
)

print("Serving on https://localhost:4443")
httpd.serve_forever()
