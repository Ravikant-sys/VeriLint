import http.server
import socketserver
import json
from verilint.core import VerilintCore

class VerilintHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        # Serve UI files by default from /ui directory
        super().__init__(*args, directory="/home/minion/Documents/Verilint/ui", **kwargs)

    def do_POST(self):
        if self.path == '/analyze':
            content_length = int(self.headers['Content-Length'])
            post_data = self.rfile.read(content_length)
            req = json.loads(post_data.decode('utf-8'))
            code = req.get('code', '')
            
            try:
                engine = VerilintCore()
                results = engine.run_json(code)
                
                self.send_response(200)
                self.send_header('Content-Type', 'application/json')
                self.end_headers()
                self.wfile.write(json.dumps(results).encode('utf-8'))
            except Exception as e:
                self.send_response(500)
                self.end_headers()
                self.wfile.write(json.dumps({'error': str(e)}).encode('utf-8'))
        else:
            self.send_error(404)

if __name__ == "__main__":
    PORT = 8000
    print(f"Starting Verilint UI Server on port {PORT}...")
    socketserver.TCPServer.allow_reuse_address = True
    with socketserver.TCPServer(("", PORT), VerilintHandler) as httpd:
        httpd.serve_forever()
