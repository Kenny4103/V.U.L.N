import subprocess

def remove_file(filename):
    try:
        # Run the 'rm' command using subprocess
        subprocess.run(["rm", filename])
        print(f"File '{filename}' removed successfully.")
    except Exception as e:
        print(f"An error occurred: {str(e)}")


