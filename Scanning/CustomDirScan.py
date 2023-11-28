import os
import subprocess
import sys

<<<<<<< HEAD
clean = []
infected = []
clean_path = []
infected_path = []
=======
>>>>>>> e0616b7 (changes made are done)
def scan_directory(path):
    path = "'" + path + "'"
    try:
        cmd = ["clamscan", "-r", path]
<<<<<<< HEAD
        #print("COMMAND TO EXEC: ", cmd);
        print(f"Running command: {' '.join(cmd)}")
=======
        #print(f"Running command: {' '.join(cmd)}")
>>>>>>> e0616b7 (changes made are done)
        result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, shell=True)
        
        if result.returncode == 0:
            return f"{path} is clean."
        else:
            return f"{path} may contain infected files. ClamAV detected an issue."
    except Exception as e:
        return f"An error occurred while scanning {path}: {str(e)}"

if __name__ == "__main__":
<<<<<<< HEAD
    if len(sys.argv) !=2:
        print("Usage: python script.py <direccctory_to_san>")
        sys.exit(1)

    directory_to_Scan = sys.argv[1]
    
=======
    if (sys.argv) != 2:
        print("Usage: pythonscript sucks")
        sys.exit(1)

    directory_to_Scan = sys.argv[1]

>>>>>>> e0616b7 (changes made are done)
    subdirs_and_files = [os.path.join(directory_to_Scan, item) for item in os.listdir(directory_to_Scan)]
    results = [scan_directory(path) for path in subdirs_and_files]

    for result in results:
        print(result)
  