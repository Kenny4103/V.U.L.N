import os
import subprocess
import sys

def scan_directory(path):
    try:
        cmd = [clamscan_path, "-r", path]
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)

        if result.returncode == 0:
            return f"{path} is clean."
        else:
            return f"{path} may contain infected files. ClamAV detected an issue."
    except Exception as e:
        return f"An error occurred while scanning {path}: {str(e)}"

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <directory_to_scan>")
        sys.exit(1)

    directory_to_scan = sys.argv[1]

    # Get the directory of the Python script
    script_directory = os.path.dirname(os.path.abspath(__file__))
    print("Directory of the Python script:", script_directory)

    # Define the path to the ClamAV clamscan executable
    clamscan_path = "/usr/bin/clamscan"  # Use the actual path to clamscan

    subdirs_and_files = [os.path.join(directory_to_scan, item) for item in os.listdir(directory_to_scan)]
    results = [scan_directory(path) for path in subdirs_and_files]

    for result in results:
        print(result)
