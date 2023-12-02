import os
import subprocess
import sys
from http.server import SimpleHTTPRequestHandler
from socketserver import TCPServer
from threading import Thread

# Define a global variable to store progress messages
progress_messages = []

def send_progress(message):
    # Add the progress message to the global variable
    progress_messages.append(message)

# Create a simple HTTP server handler to serve progress messages
class ProgressHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        global progress_messages
        # Send the latest progress message
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(bytes("\n".join(progress_messages), "utf-8"))
        # Clear progress messages after sending
        progress_messages = []

def scan_directory(path):
<<<<<<< HEAD
    try:
        cmd = ["clamscan", "-r", path]
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        
        if result.returncode == 0:
=======
    #path = "'" + path + "'"
    try:
        cmd = ["clamscan", "-r", path]
        #print(f"Running command: {' '.join(cmd)}")

        # Start the HTTP server in a separate thread
        server_thread = Thread(target=start_http_server)
        server_thread.start()

        # Use the subprocess.PIPE to capture both stdout and stderr
        print(f"Running command: {' '.join(cmd)}")

        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            shell=True
        )

        # Read and print the output line by line
        while True:
            line = process.stdout.readline()
            if not line:
                break
            print(line, end='')
            # Send progress messages to the HTTP server
            send_progress(line)


        process.stdout.close()
        process.wait()

        if process.returncode == 0:
>>>>>>> justin2
            return f"{path} is clean."
        else:
            return f"{path} may contain infected files. ClamAV detected an issue."
    except Exception as e:
        return f"An error occurred while scanning {path}: {e}"

def start_http_server():
    # Start the HTTP server on port 8000
    httpd = TCPServer(("", 8000), ProgressHandler)
    print("HTTP server started on port 8000")
    httpd.serve_forever()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory_to_scan>")
        sys.exit(1)

    directory_to_scan = sys.argv[1]

    try:
        for root, dirs, files in os.walk(directory_to_scan):
            for file in files:
                path = os.path.join(root, file)
                print(scan_directory(path))
    except Exception as e:
        print(f"An error occurred: {e}")
