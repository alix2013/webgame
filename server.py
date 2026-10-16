import http.server
import socketserver
import os

# Set the port number
PORT = int(os.environ.get("PORT", 8000))

# Use the built-in request handler to serve files from the current folder
Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Serving HTTP on port {PORT}...")
    # Keep the server running until you manually stop the script (Ctrl+C)
    httpd.serve_forever()


