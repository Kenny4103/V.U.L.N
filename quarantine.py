import os
import shutil

def quarantine_file(file_path, quarantine_folder):
    try:
        # Create the quarantine folder if it doesn't exist
        if not os.path.exists(quarantine_folder):
            os.makedirs(quarantine_folder)

        # Move the file to the quarantine folder
        shutil.move(file_path, os.path.join(quarantine_folder, os.path.basename(file_path)))
        print(f"File '{file_path}' moved to quarantine.")
    except Exception as e:
        print(f"Error while quarantining file '{file_path}': {e}")

