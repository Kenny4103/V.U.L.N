import subprocess
import concurrent.futures
import os
import json
import time
from tqdm import tqdm
import sys

# Replace 'clamscan_path' with the full path to your clamscan.exe executable
clamscan_path = r"/usr/bin/clamscan"

# Replace 'directory_to_Scan' with the path to the directory you want to scan
directory_to_Scan = r"/home/justin1/vuln/lib"

def scan_directory(path):
    try:
        result = subprocess.run([clamscan_path, "-r", path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        if result.returncode == 0:
            return {"status": "clean", "message": f"{path} is clean."}
        else:
            return {"status": "infected", "message": f"{path} may contain infected files.", "output": result.stdout, "error": result.stderr}
    except Exception as e:
        return {"status": "error", "message": f"An error occurred while scanning {path}: {str(e)}"}

if __name__ == "__main__":
    max_threads = 10  # Set the maximum number of threads

    # Check if running in a non-interactive environment
    is_non_interactive = not sys.stdout.isatty()

    with concurrent.futures.ThreadPoolExecutor(max_workers=max_threads) as executor:
        # List all subdirectories and files in the main directory
        subdirs_and_files = [os.path.join(directory_to_Scan, item) for item in os.listdir(directory_to_Scan)]

        # Scan each directory or file concurrently
        results = list(tqdm(executor.map(scan_directory, subdirs_and_files), total=len(subdirs_and_files), disable=is_non_interactive))

    # Print the results as a JSON string
    print(json.dumps(results))
