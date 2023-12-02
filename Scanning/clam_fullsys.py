import subprocess
import concurrent.futures
import os

# Use the 'clamscan' command without specifying the full path
clamscan_path = "clamscan"

# Set the root directory to perform a full system scan
directory_to_Scan = "/"

def scan_directory(path):
    try:
        result = subprocess.run([clamscan_path, "-r", path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        if result.returncode == 0:
            return f"{path} is clean."
        else:
            return f"{path} may contain infected files. ClamAV detected an issue.\n{result.stdout}\n{result.stderr}"
    except Exception as e:
        return f"An error occurred while scanning {path}: {str(e)}"

if __name__ == "__main__":
    # Set the maximum number of threads for concurrent scanning
    max_threads = 8

    with concurrent.futures.ThreadPoolExecutor(max_workers=max_threads) as executor:
        # Create a list of items in the root directory
        subdirs_and_files = [item for item in os.listdir(directory_to_Scan)]
       
        # Scan each directory or file concurrently
        results = list(executor.map(scan_directory, subdirs_and_files))

    for result in results:
        print(result)