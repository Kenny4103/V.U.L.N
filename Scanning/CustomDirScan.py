import os
import subprocess
import sys

clean = []
infected = []
clean_path = []
infected_path = []
def scan_directory(path):
    path = "'" + path + "'"
    try:
        cmd = ["clamscan", "-r", path]
        #print("COMMAND TO EXEC: ", cmd);
        print(f"Running command: {' '.join(cmd)}")
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)
        
        if result.returncode == 0:
            clean.append("clean")
            clean_path.append(f"{path}")
            return f"{path} is clean."
        else:
            infected.append("infected")
            infected_path.append(f"{path}")
            return f"{path} may contain infected files. ClamAV detected an issue."
    except Exception as e:
        return f"An error occurred while scanning {path}: {str(e)}"

if __name__ == "__main__":
    if len(sys.argv) !=2:
        print("Usage: python script.py <direccctory_to_san>")
        sys.exit(1)

    directory_to_Scan = sys.argv[1]
    
    subdirs_and_files = [os.path.join(directory_to_Scan, item) for item in os.listdir(directory_to_Scan)]
    results = [scan_directory(path) for path in subdirs_and_files]

    for result in results:
        print(result)
    for x in clean:
        print(x)
    for y in infected:
        print(y)
    for z in clean_path:
        print(z)
    for a in infected_path:
        print(a)


