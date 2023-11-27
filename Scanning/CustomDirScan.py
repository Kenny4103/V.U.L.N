import os
import subprocess
import sys

def scan_directory(path):
    path = "'" + path + "'"
    try:
        cmd = ["clamscan", "-r", path]
        #print(f"Running command: {' '.join(cmd)}")
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)
        
        if result.returncode == 0:
            return f"{path} is clean."
        else:
            return f"{path} may contain infected files. ClamAV detected an issue."
    except Exception as e:
        return f"An error occurred while scanning {path}: {str(e)}"

if __name__ == "__main__":
    if (sys.argv) != 2:
        print("Usage: pythonscript sucks")
        sys.exit(1)

    directory_to_Scan = sys.argv[1]

    subdirs_and_files = [os.path.join(directory_to_Scan, item) for item in os.listdir(directory_to_Scan)]
    results = [scan_directory(path) for path in subdirs_and_files]

    for result in results:
        print(result)
