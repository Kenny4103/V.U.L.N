import subprocess
from concurrent.futures import ThreadPoolExecutor

def scan_file(path):
    try:
        result = subprocess.run(['clamscan', path], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, check=True)

        if result.returncode == 0:
            return f"No viruses found in {path}"
        else:
            return f"Virus detected in {path}:\n{result.stdout}"
    except subprocess.CalledProcessError as e:
        return f"An error occurred while scanning {path}: {e.stderr}"

def run_clamscan(target):
    with ThreadPoolExecutor(max_workers=4) as executor:  # Adjust max_workers as needed
        futures = [executor.submit(scan_file, file) for file in target]

    for future in futures:
        result = future.result()
        if "No viruses found" in result:
            print(result)

    for future in futures:
        result = future.result()
        if "Virus detected" in result:
            print(result)

if __name__ == "__main__":
    target_path = '/home/kali/Documents'  # Replace with the path to the file or directory you want to scan
    run_clamscan([target_path])