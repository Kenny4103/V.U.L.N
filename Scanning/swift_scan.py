import subprocess
import sys
import os
import logging

def scan_file(path):
    try:
        result = subprocess.run(['clamscan', path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)

        if result.returncode == 0:
            return f"No viruses found in {path}"
        else:
            return f"Virus detected in {path}:\n{result.stdout}"
    except subprocess.CalledProcessError as e:
        return f"Error scanning {path}: {e.stderr}"
    except OSError as e:
        return f"Error accessing {path}: {e}"


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory_to_scan>")
        sys.exit(1)

    directory_to_scan = sys.argv[1]

    try:
        if not os.path.exists(directory_to_scan):
            print(f"Error: Directory '{directory_to_scan}' not found.")
            sys.exit(1)

        for root, dirs, files in os.walk(directory_to_scan):
            for file in files:
                path = os.path.join(root, file)
                print(scan_file(path))
    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        logging.exception("An unexpected error occurred.")